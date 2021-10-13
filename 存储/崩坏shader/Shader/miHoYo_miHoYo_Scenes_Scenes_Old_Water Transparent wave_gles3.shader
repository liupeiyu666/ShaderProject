//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Water Transparent wave" {
Properties {
_RefColor ("Reflection Color", Color) = (1,1,1,1)
_ReflectionTex ("Reflection", 2D) = "white" { }
_WaterColor ("Water Color (used when disable realtime reflection)", Color) = (0,0,0,0)
_NormalMap ("Normal Map", 2D) = "white" { }
_CausticMap ("Caustic Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump Scale 1", Float) = 1
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic Scale", Float) = 1
_CausticFresnelFactors ("Caustic Fresnel Factors", Vector) = (1,1,0,0)
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_ReflectionFresnelFactors ("Reflection Fresnel Factors", Vector) = (1,1,0,0)
_WaveTex ("WaveTex", 2D) = "black" { }
_WaveTexMask ("WaveTex", 2D) = "black" { }
_WaveSpeed ("WaveSpeed", Float) = -12.64
_WaveRange ("WaveRange", Float) = 0.3
_NoiseRange ("NoiseRange", Float) = 6.43
_WaveDelta ("WaveDelta", Float) = 2.43
_WaveZ ("WaveZ", Float) = 0.37
_WaveColorScale ("WaveColorScale", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 56736
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD4.www + _RefractionColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    SV_Target0.w = _RefractionColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat9;
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
    u_xlat1.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat1.xy;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat5.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat1.x);
    u_xlat16_2.x = (-u_xlat1.y) * u_xlat9 + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_6 = u_xlat16_2.x * _ReflectionFresnelFactors.x;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _ReflectionFresnelFactors.y;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_2.y = u_xlat16_6 + _ReflectionFresnelFactors.z;
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _CausticFresnelFactors.y;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + _CausticFresnelFactors.z;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.y = float(1.0) / u_xlat1.x;
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
        u_xlat3.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
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
        u_xlat9 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat9 = max(u_xlat9, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat9);
        u_xlat5.x = u_xlat1.y * _FogEffectLimit;
        u_xlat5.x = max(u_xlat5.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat1.xxx * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.z = in_COLOR0.w;
    vs_TEXCOORD4.xw = u_xlat16_2.yx;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
float u_xlat13;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.y = float(1.0) / u_xlat12;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	mediump vec4 _ReflectionFresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec2 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	mediump vec4 _CausticFresnelFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat2.xy = vec2(_Time.y * _BumpVelocity0.xxyx.y, _Time.y * float(_BumpVelocity0.y));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale0, _BumpScale0)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _BumpVelocity1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BumpScale1, _BumpScale1)) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * _CausticVelocity.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(vec2(_CausticScale, _CausticScale)) + u_xlat2.xy;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = inversesqrt(u_xlat15);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.y = float(1.0) / u_xlat15;
    u_xlat16_3 = (-u_xlat1.y) * u_xlat1.x + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.00100000005);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_8 = u_xlat16_3 * _ReflectionFresnelFactors.x;
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _CausticFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _CausticFresnelFactors.z;
    vs_TEXCOORD4.w = u_xlat16_3;
    u_xlat16_3 = exp2(u_xlat16_8);
    u_xlat16_3 = u_xlat16_3 * _ReflectionFresnelFactors.y;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_3 = u_xlat16_3 + _ReflectionFresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveDelta;
uniform 	mediump float _WaveRange;
uniform 	mediump float _NoiseRange;
uniform 	mediump float _WaveZ;
uniform 	mediump float _WaveColorScale;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _CausticMap;
uniform lowp sampler2D _WaveTexMask;
uniform lowp sampler2D _WaveTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat17;
void main()
{
    u_xlat10_0.xyz = texture(_WaveTexMask, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.x = min(u_xlat10_0.x, _WaveZ);
    u_xlat16_1.x = u_xlat16_1.x / _WaveZ;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = _Time.x * _WaveSpeed + _WaveDelta;
    u_xlat0.x = u_xlat10_0.z * _NoiseRange + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat12.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat2.y = float(1.0);
    u_xlat12.y = float(1.0);
    u_xlat10_3.xyz = texture(_WaveTex, u_xlat12.xy).xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
    u_xlat16_6.x = u_xlat10_0.z * _NoiseRange;
    u_xlat0.x = _Time.x * _WaveSpeed + u_xlat16_6.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = _WaveRange * u_xlat0.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.0;
    u_xlat0.x = u_xlat10_0.z * u_xlat0.x;
    u_xlat16_1.x = (-u_xlat10_0.y) + 1.0;
    u_xlat10_5.xyz = texture(_WaveTex, u_xlat2.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_4.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_4.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CausticMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat17 = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat0.w = (-_RefractionColor.w) + 1.0;
    u_xlat0 = vec4(u_xlat17) * u_xlat0 + _RefractionColor;
    u_xlat0.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_WaveColorScale, _WaveColorScale, _WaveColorScale)) + u_xlat0.xyz;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
}
}
}
}