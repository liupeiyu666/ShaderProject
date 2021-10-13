//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Bamboo (wind)" {
Properties {
_MayaScale ("Scale Compared to Maya", Float) = 0.01
_Scale ("Scale", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_BottomColor ("Bottom Color", Color) = (1,1,1,1)
_MiddleColor ("Middle Color", Color) = (1,1,1,1)
_MiddleColorPosition ("Middle Color Position", Range(0.01, 0.99)) = 0.5
_TopColor ("Top Color", Color) = (1,1,1,1)
_Width ("Width", Range(0.0001, 1)) = 0.0001
_Ambient ("Ambient", Range(0.01, 10)) = 1
_AmbientRimIndex ("Ambient Rim Index", Range(0.01, 100)) = 10
_AmbientRimScale ("Ambient Rim Scale", Range(0.01, 10)) = 0
_Diffuse ("Diffuse", Range(0.01, 10)) = 1
_Specular ("Specular", Range(0.01, 10)) = 1
_Shininess ("Shininess", Range(0.01, 100)) = 10
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_LightDir ("Light Dir", Vector) = (0,0,1,0)
_LightUp ("Light Up", Vector) = (0,1,0,0)
_LightRight ("Light Right", Vector) = (1,0,0,0)
_ShadowTex ("Shadow Tex (R)", 2D) = "white" { }
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend InTensity", Range(0, 1)) = 0
_BendSpeed ("Bend Speed", Range(0, 1)) = 0
_BendVariance ("Bend Variance", Float) = 1
_SideBend ("Side Bend", Range(0, 10)) = 0
_Gust ("Gust", Float) = 1
_GlobalSpeed ("Global Speed", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 57559
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
vec4 u_xlat8;
vec4 u_xlat9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat14;
vec3 u_xlat17;
mediump vec3 u_xlat16_23;
vec2 u_xlat27;
mediump float u_xlat16_36;
float u_xlat40;
float u_xlat41;
bool u_xlatb41;
float u_xlat42;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat2.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat41 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb41 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat5.xyz = (bool(u_xlatb41)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat6 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat6;
    u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat7.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.w = sqrt(u_xlat41);
    u_xlat42 = dot(u_xlat4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat42 = u_xlat42 * _BendVariance;
    u_xlat4.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat4.x = _GlobalSpeed * u_xlat4.x + 1.0;
    u_xlat17.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat4.x = _miHoYo_Wind.w * u_xlat4.x + u_xlat17.x;
    u_xlat42 = u_xlat4.x * _BendSpeed + u_xlat42;
    u_xlat4 = vec4(u_xlat42) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat8 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat8 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat4.x = _miHoYo_WindParams1.x * _Gust + u_xlat4.x;
    u_xlat17.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat17.x = inversesqrt(u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xxx * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat17.xyz;
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat6.xyz;
    u_xlat41 = u_xlat42 + -0.5;
    u_xlat8 = vec4(u_xlat41) * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat8 = fract(u_xlat8);
    u_xlat8 = u_xlat8 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat9 = abs(u_xlat8) * abs(u_xlat8);
    u_xlat8 = -abs(u_xlat8) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat8 = u_xlat9 * u_xlat8 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.z = dot(u_xlat8, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.w = (-u_xlat5.z);
    u_xlat7.xy = u_xlat5.zx * vec2(-1.0, 1.0);
    u_xlat41 = dot(u_xlat5.wx, u_xlat7.xy);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat7.xzy;
    u_xlat5.xyz = vec3(u_xlat7.z * u_xlat5.x, u_xlat7.w * u_xlat5.y, u_xlat7.z * u_xlat5.z);
    u_xlat7.xz = u_xlat7.ww;
    u_xlat7.y = _BendIntensity;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xz = u_xlat5.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat4.xyz = u_xlat5.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat4.xyz;
    u_xlat41 = u_xlat16_0 * _Width;
    u_xlat41 = u_xlat41 * _MayaScale;
    u_xlat5.xyz = u_xlat3.xyz * vec3(u_xlat41);
    u_xlat5.xyz = u_xlat5.xyz * in_COLOR0.xxx;
    u_xlat6.xyz = u_xlat5.xyz * vec3(_Scale) + u_xlat4.xyz;
    u_xlat0 = u_xlat6.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat6.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat6.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat6.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat40) + _LightDir.xyz;
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    vs_TEXCOORD4.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_10 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_23.x = u_xlat16_10 + 1.0;
    u_xlat16_23.x = floor(u_xlat16_23.x);
    u_xlat16_23.x = max(u_xlat16_23.x, 0.0);
    u_xlati1 = int(u_xlat16_23.x);
    u_xlat16_23.x = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_36 = (-_MiddleColorPosition) + 1.0;
    u_xlat16_10 = u_xlat16_10 / u_xlat16_36;
    u_xlat16_11.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_12.xyz = _MiddleColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_12.xyz;
    u_xlat16_10 = (u_xlati1 != 0) ? u_xlat16_10 : u_xlat16_23.x;
    u_xlat16_23.xyz = (-u_xlat16_11.xyz) + u_xlat16_12.xyz;
    vs_COLOR0.xyz = vec3(u_xlat16_10) * u_xlat16_23.xyz + u_xlat16_11.xyz;
    u_xlat27.x = dot(_LightRight, u_xlat6);
    u_xlat27.y = dot(_LightUp, u_xlat6);
    vs_TEXCOORD1.xy = u_xlat27.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
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
        u_xlat27.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat27.x = max(u_xlat27.x, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / u_xlat27.xx;
        u_xlat14.x = u_xlat1.y * _FogEffectLimit;
        u_xlat14.x = max(u_xlat14.x, _FogEffectStart);
        u_xlat0.w = min(u_xlat14.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat14.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat0.xyz = u_xlat1.xxx * u_xlat14.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat0;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = (-u_xlat2.xyz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
bool u_xlatb26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.w = u_xlat5.w;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat25 = sqrt(u_xlat25);
    u_xlat27 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat25>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat25>=u_xlat3.x;
#endif
    u_xlat11 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _Mihoyo_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat3.y = exp2(u_xlat11);
    u_xlat3.xy = (-u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat11 = u_xlat3.y / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_6 = (u_xlatb26) ? u_xlat11 : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat26 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat26 = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	float _Scale;
uniform 	float _MayaScale;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _BottomColor;
uniform 	mediump vec3 _MiddleColor;
uniform 	mediump float _MiddleColorPosition;
uniform 	mediump vec3 _TopColor;
uniform 	float _Width;
uniform 	vec4 _LightDir;
uniform 	vec4 _LightUp;
uniform 	vec4 _LightRight;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_14;
vec2 u_xlat17;
float u_xlat19;
mediump float u_xlat16_22;
float u_xlat24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat8.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat8.x;
    u_xlat8.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat8.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat8.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat8.zzz + u_xlat1.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat8.xyz, vec3(1.0, 1.0, 1.0));
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
    u_xlat0.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat8.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xyz;
    u_xlat8.xz = u_xlat8.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat8.xyz = u_xlat8.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat25 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat25 = _miHoYo_WindParams1.x * _Gust + u_xlat25;
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat8.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_6 = in_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat24 = u_xlat16_6 * _Width;
    u_xlat24 = u_xlat24 * _MayaScale;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(u_xlat25) + _LightDir.xyz;
    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.zxy;
    u_xlat1.xyz = u_xlat3.yzx * u_xlat1.yzx + (-u_xlat4.xyz);
    vs_TEXCOORD2.xyz = (-u_xlat3.xyz);
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat1.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Scale) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat1;
    u_xlat16_6 = in_COLOR0.y / _MiddleColorPosition;
    u_xlat16_14.x = (-_MiddleColorPosition) + 1.0;
    u_xlat16_22 = in_COLOR0.y + (-_MiddleColorPosition);
    u_xlat16_14.x = u_xlat16_22 / u_xlat16_14.x;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati1 = int(u_xlat16_22);
    u_xlat16_6 = (u_xlati1 != 0) ? u_xlat16_14.x : u_xlat16_6;
    u_xlat16_14.xyz = _MiddleColor.xyz;
    u_xlat16_14.xyz = (int(u_xlati1) != 0) ? _TopColor.xyz : u_xlat16_14.xyz;
    u_xlat16_7.xyz = (int(u_xlati1) != 0) ? _MiddleColor.xyz : vec3(_BottomColor.x, _BottomColor.y, _BottomColor.z);
    u_xlat16_14.xyz = u_xlat16_14.xyz + (-u_xlat16_7.xyz);
    vs_COLOR0.xyz = vec3(u_xlat16_6) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat25>=u_xlat11);
#else
    u_xlatb11 = u_xlat25>=u_xlat11;
#endif
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor3.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat19 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat3.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat27 : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14.x = (-u_xlat3.x) + 2.0;
    u_xlat16_14.x = u_xlat3.x * u_xlat16_14.x;
    u_xlat3.x = u_xlat16_14.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat27 = (-u_xlat3.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27);
    u_xlat4.w = u_xlat26 * u_xlat27;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat5.w;
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat25 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat26) + 2.0;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = u_xlat26 * _HeigtFogColDelta2.w;
    u_xlat26 = (u_xlatb11) ? u_xlat3.x : u_xlat26;
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _Mihoyo_FogColor2.w;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = min(u_xlat26, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat3.x = u_xlat19 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat25 * _HeigtFogParams2.y;
    u_xlat25 = u_xlat25 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = (-u_xlat25) + 2.0;
    u_xlat16_14.x = u_xlat25 * u_xlat16_14.x;
    u_xlat25 = u_xlat16_14.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat25 = u_xlat25 + 1.0;
    u_xlat16_6 = u_xlat25 * u_xlat16_6;
    u_xlat25 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat25) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat3.w = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat25) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat17.x = dot(_LightRight, u_xlat0);
    u_xlat17.y = dot(_LightUp, u_xlat0);
    vs_TEXCOORD1.xy = u_xlat17.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Ambient;
uniform 	mediump float _AmbientRimIndex;
uniform 	mediump float _AmbientRimScale;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _LightDir;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<vs_TEXCOORD0.x);
#else
    u_xlatb12 = 0.5<vs_TEXCOORD0.x;
#endif
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = (u_xlatb12) ? vs_TEXCOORD0.x : u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_1.x * 2.0 + -1.0;
    u_xlat16_2 = (-u_xlat16_12) * u_xlat16_12 + 1.0;
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimIndex;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 * _AmbientRimScale + _Ambient;
    u_xlat16_2 = sqrt(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD3.xyz;
    u_xlat16_1.x = vs_TEXCOORD0.x * 2.0 + -1.0;
    u_xlat0.xyz = u_xlat2.xyz * (-u_xlat16_1.xxx) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _LightDir.xyz);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat16_1.x = max(u_xlat2.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * _Diffuse;
    u_xlat10_4 = texture(_ShadowTex, vs_TEXCOORD1.xy).x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_4 + u_xlat16_12;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_2.w;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_3.x = u_xlat10_4 * u_xlat0.x;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat16_13 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + vs_COLOR1.xyz;
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
Fallback "Diffuse"
}