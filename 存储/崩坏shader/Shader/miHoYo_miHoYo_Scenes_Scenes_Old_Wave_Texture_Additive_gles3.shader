//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Wave_Texture_Additive" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_Wavesspeed ("Waves speed", Range(-10, 10)) = 0.75
_GradientPower ("Gradient Power", Float) = 5
[Toggle(INVERT_GRAD)] _InvertGrad ("Invert Grad", Float) = 0
[Toggle(INVERT_V)] _InvertV ("Invert V", Float) = 0
_NormalMap ("Normal Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump Scale 1", Float) = 1
_ClampYMin ("Clamp Y Min", Float) = 0
_ClampYMax ("Clamp Y Max", Float) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 7561
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat0 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat1.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat0.xy;
    u_xlat1.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat0.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb8 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb8){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * (-u_xlat8.xy);
        u_xlat8.xy = u_xlat8.xy * vec2(1.44269502, 1.44269502);
        u_xlat8.xy = exp2(u_xlat8.xy);
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat8.x = u_xlat8.x * _FogEffectLimit;
        u_xlat8.x = max(u_xlat8.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat8.x = u_xlat8.x + (-_FogStartDistance);
        u_xlat8.x = max(u_xlat8.x, 0.0);
        u_xlat8.xy = u_xlat8.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat8.xy = u_xlat8.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat8.xy = u_xlat8.yx / u_xlat2.xx;
        u_xlat12 = u_xlat8.y * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat8.x = u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat8.x = (-u_xlat8.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat8.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR1.www * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_BumpScale0, _BumpScale0, _BumpScale1, _BumpScale1);
    u_xlat2.xy = vec2(_BumpVelocity0.x, _BumpVelocity0.y) * _Time.yy + u_xlat1.xy;
    u_xlat2.zw = vec2(_BumpVelocity1.x, _BumpVelocity1.y) * _Time.yy + u_xlat1.zw;
    phase0_Output0_1 = u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
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
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _GradientPower;
uniform 	mediump float _Distortion;
uniform 	mediump float _Wavesspeed;
uniform 	mediump float _ClampYMin;
uniform 	mediump float _ClampYMax;
uniform 	mediump float _InvertGrad;
uniform 	mediump float _InvertV;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
float u_xlat6;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ClampYMax<vs_TEXCOORD2.y);
#else
    u_xlatb0 = _ClampYMax<vs_TEXCOORD2.y;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.y<_ClampYMin);
#else
    u_xlatb0 = vs_TEXCOORD2.y<_ClampYMin;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.x = _Wavesspeed * 0.100000001;
    u_xlat8.x = u_xlat16_1.x * _Time.y;
    u_xlat8.xy = u_xlat8.xx * vec2(0.0, 1.10000002) + vs_TEXCOORD2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertV);
#else
    u_xlatb2 = 0.0<_InvertV;
#endif
    if(u_xlatb2){
        u_xlat16_1.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_1.xy = u_xlat8.xy + u_xlat16_1.xy;
        u_xlat16_1.z = (-u_xlat16_1.y) + 1.0;
        u_xlat10_1 = texture(_MainTex, u_xlat16_1.xz);
        u_xlat16_1 = u_xlat10_1;
    } else {
        u_xlat16_3.xy = (-u_xlat16_0.xy) * vec2(vec2(_Distortion, _Distortion)) + vs_TEXCOORD2.xy;
        u_xlat16_3.xy = u_xlat8.xy + u_xlat16_3.xy;
        u_xlat10_1 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_1 = u_xlat10_1;
    //ENDIF
    }
    u_xlat16_0 = vs_COLOR0 * _MainColor;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_EmissionScaler, _EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_1.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GradientPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<_InvertGrad);
#else
    u_xlatb2 = 0.0<_InvertGrad;
#endif
    u_xlat16_6 = (-u_xlat16_1.x) + 1.0;
    u_xlat6 = max(u_xlat16_6, 0.0);
    u_xlat2 = (u_xlatb2) ? u_xlat6 : u_xlat16_1.x;
    u_xlat2 = u_xlat16_0.w * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat2;
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
}
}
}
}