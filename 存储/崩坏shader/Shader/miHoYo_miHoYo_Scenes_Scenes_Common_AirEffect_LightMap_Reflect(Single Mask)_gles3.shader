//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_Reflect(Single Mask)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EmissionColor ("Emission Color", Color) = (1,1,1,1)
_Emission ("Emission", Range(1, 100)) = 1
_EmissionFactor ("Emission Factor", Range(0, 1)) = 0
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
[Toggle(INT_PING_PONG)] _LigthMapIntPingPong ("Light Map Intensity Ping Pong", Float) = 0
_Magnitude ("Magnitude Of Ping Pong", Range(0, 5)) = 3
_MinValue ("Min Value Of Ping Pong", Range(0, 2)) = 0.5
_Speed ("Speed Of Ping Pong", Range(0, 3)) = 0.5
[Toggle(HIGH_FOG)] _HighFog ("HighFog", Float) = 0
_HighFogColor ("HighFogColor", Color) = (1,1,1,1)
_FogHighStartDistance ("FogHighStartDistance", Float) = 8.5
_FogHighIntensity ("FogHighIntensity", Float) = 0.03
_FogHighEffectLimit ("FogHighEffectLimit", Float) = 0.7
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 54642
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat5.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat5.z = dot(u_xlat2.xy, u_xlat1.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat1.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat1.xzw, u_xlat1.xzw);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat1.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xz = u_xlat1.xz * (-u_xlat1.xz);
        u_xlat1.xz = u_xlat1.xz * vec2(1.44269502, 1.44269502);
        u_xlat1.xz = exp2(u_xlat1.xz);
        u_xlat21 = (-u_xlat1.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat2.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat14 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat14 = max(u_xlat14, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat14);
        u_xlat7.x = u_xlat0.y * _FogEffectLimit;
        u_xlat7.x = max(u_xlat7.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat7.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat7.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat7.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = u_xlat1.y;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat15;
bool u_xlatb15;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xy;
    u_xlat2.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat0.xwy + (-u_xlat2.xyz);
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat6.x = dot(u_xlat16_4.xy, u_xlat2.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.z = dot(u_xlat5.xy, u_xlat2.xz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb15 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb15){
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * (-u_xlat15.xy);
        u_xlat15.xy = u_xlat15.xy * vec2(1.44269502, 1.44269502);
        u_xlat15.xy = exp2(u_xlat15.xy);
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat15.x = u_xlat15.x * _FogEffectLimit;
        u_xlat15.x = max(u_xlat15.x, _FogEffectStart);
        u_xlat3.w = min(u_xlat15.x, _FogEffectLimit);
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.yyy * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xzw = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat15.x = dot(u_xlat2.xzw, u_xlat2.xzw);
        u_xlat15.x = sqrt(u_xlat15.x);
        u_xlat15.x = u_xlat15.x + (-_FogStartDistance);
        u_xlat15.x = max(u_xlat15.x, 0.0);
        u_xlat15.xy = u_xlat15.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat15.xy = u_xlat15.xy * vec2(500.0, 1000.0);
        u_xlat2.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat15.xy = u_xlat15.yx / u_xlat2.xx;
        u_xlat22 = u_xlat15.y * _FogEffectLimit;
        u_xlat22 = max(u_xlat22, _FogEffectStart);
        u_xlat3.w = min(u_xlat22, _FogEffectLimit);
        u_xlat15.x = u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
        u_xlat15.x = (-u_xlat15.x) + 1.0;
        u_xlat2.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat15.xxx * u_xlat2.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = u_xlat2.y;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _Color;
uniform 	vec4 _EmissionColor;
uniform 	mediump float _Emission;
uniform 	mediump float _EmissionFactor;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _Magnitude;
uniform 	mediump float _MinValue;
uniform 	mediump float _Speed;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _LigthMapIntPingPong;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
vec3 u_xlat7;
mediump float u_xlat16_15;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_16 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_16) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<_LigthMapIntPingPong);
#else
    u_xlatb16 = 0.0<_LigthMapIntPingPong;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat16 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat17 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat16 = u_xlat16 / u_xlat17;
    u_xlat16 = max(u_xlat16, 0.0);
    u_xlat17 = (-u_xlat16) * _UWHeightRatio + 1.0;
    u_xlat17 = u_xlat17 * vs_TEXCOORD4.y;
    u_xlat17 = max(u_xlat17, _UWCriticalRange);
    u_xlat17 = min(u_xlat17, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb4 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_15 = (u_xlatb4) ? u_xlat17 : vs_TEXCOORD4.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat16 * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb16 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
}
}
}
Fallback "Diffuse"
}