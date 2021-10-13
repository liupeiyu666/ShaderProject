//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Reflect(Single Mask)_ARL" {
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
[Toggle(DEBUG_LIGHTMAP)] _DebugLightmap ("DebugLightmap", Float) = 0
_RGLightMap ("Rim Glow Ratio", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 27802
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
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
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3 = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat6 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
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
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
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
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.y = u_xlat1.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat5.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat2.x = dot(u_xlat16_4.xy, u_xlat1.xz);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat2.z = dot(u_xlat5.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
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
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat18 = (u_xlatb2) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat19 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3 = (u_xlatb19) ? u_xlat8.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3 = u_xlat19 * u_xlat16_3;
    u_xlat19 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat8.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat8.xxx;
    u_xlat3.w = u_xlat18 * u_xlat8.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_4.x = (-u_xlat6.x) + 2.0;
    u_xlat16_4.x = u_xlat6.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat8.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb2) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_4.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.w = u_xlat12 * u_xlat6.x;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
lowp float u_xlat10_19;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_19 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_19) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_18 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_18) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat16_18 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.w = u_xlat0.y;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat7 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat1.xyz;
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
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat7 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat3.w = u_xlat7 * u_xlat14.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.w = u_xlat0.y;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat7 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat1.xyz;
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
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat7 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat3.w = u_xlat7 * u_xlat14.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.w = u_xlat0.y;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat7 = u_xlat0.z * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat1.xyz;
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
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat7 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat3.w = u_xlat7 * u_xlat14.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat22 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat10.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat22) + 2.0;
    u_xlat16_11 = u_xlat22 * u_xlat16_11;
    u_xlat22 = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat22 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat4.w = u_xlat21 * u_xlat10.x;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0.y;
    u_xlat16_5.x = (-u_xlat21) + 2.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_5.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat14 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat0.x) + 2.0;
    u_xlat16_12 = u_xlat0.x * u_xlat16_12;
    u_xlat0.x = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat3) + u_xlat4;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat22 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat10.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat22) + 2.0;
    u_xlat16_11 = u_xlat22 * u_xlat16_11;
    u_xlat22 = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat22 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat4.w = u_xlat21 * u_xlat10.x;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0.y;
    u_xlat16_5.x = (-u_xlat21) + 2.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_5.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat14 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat0.x) + 2.0;
    u_xlat16_12 = u_xlat0.x * u_xlat16_12;
    u_xlat0.x = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat3) + u_xlat4;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat10;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat2.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat21 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + (-_UWFogDistStart);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat2.xy = vec2(u_xlat21) * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat1.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat3.y = u_xlat1.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_5.x = cos(_CamRotate);
    u_xlat6.x = (-u_xlat16_4);
    u_xlat16_5.y = u_xlat16_4;
    u_xlat3.x = dot(u_xlat16_5.xy, u_xlat1.xz);
    u_xlat6.y = u_xlat16_5.x;
    u_xlat3.z = dot(u_xlat6.xy, u_xlat1.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat21) + 2.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat22 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat22 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat22 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_4 = (u_xlatb22) ? u_xlat10.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat22) + 2.0;
    u_xlat16_11 = u_xlat22 * u_xlat16_11;
    u_xlat22 = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_4 = u_xlat22 * u_xlat16_4;
    u_xlat22 = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat4.w = u_xlat21 * u_xlat10.x;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0.y;
    u_xlat16_5.x = (-u_xlat21) + 2.0;
    u_xlat16_5.x = u_xlat21 * u_xlat16_5.x;
    u_xlat1.xyz = u_xlat16_5.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_5.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat14 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = (-u_xlat0.x) + 2.0;
    u_xlat16_12 = u_xlat0.x * u_xlat16_12;
    u_xlat0.x = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = min(u_xlat16_5.x, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat3) + u_xlat4;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD4.xyz = u_xlat2.yzw;
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
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
vec3 u_xlat9;
mediump float u_xlat16_21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_0.xxx) + vs_TEXCOORD3.xyz;
    u_xlat10_1.xyz = texture(_EnvTex, u_xlat16_0.xyz).xyz;
    u_xlat10_22 = texture(_ReflectMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = vec3(u_xlat10_22) * u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Reflectivity);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _Color.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(_Emission);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat10_2.www + u_xlat16_4.xyz;
    u_xlat16_21 = (-_RGLightMap) + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_RGLightMap) + u_xlat16_5.xyz;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_DebugLightmap, _LigthMapIntPingPong, _DebugLightmap, _DebugLightmap)).xy;
    u_xlat16_3.xyz = (u_xlatb1.x) ? u_xlat16_3.xyz : u_xlat16_4.xyz;
    u_xlat1.x = _Time.y * _Speed;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.5;
    u_xlat1.x = abs(u_xlat1.x) * _Magnitude + _MinValue;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat16_3.xyz = (u_xlatb1.y) ? u_xlat1.xzw : u_xlat2.xyz;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD4.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat16_3.xyz;
    u_xlat22 = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat23 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat22 = u_xlat22 / u_xlat23;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = (-u_xlat22) * _UWHeightRatio + 1.0;
    u_xlat23 = u_xlat23 * vs_TEXCOORD4.y;
    u_xlat23 = max(u_xlat23, _UWCriticalRange);
    u_xlat23 = min(u_xlat23, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat16_21 = (u_xlatb6) ? u_xlat23 : vs_TEXCOORD4.y;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat1.xyz = vec3(u_xlat16_21) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat22 * _UWFogColorHLIntensity;
    u_xlat22 = (-_UWHeightFogDensity) * u_xlat22 + 1.0;
    u_xlat22 = u_xlat22 * _UWHeightFogEffectLimit;
    u_xlat22 = max(u_xlat22, _UWHeightFogEffectStart);
    u_xlat22 = min(u_xlat22, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vs_TEXCOORD4.z<_WaterPlaneHeight);
#else
    u_xlatb22 = vs_TEXCOORD4.z<_WaterPlaneHeight;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EmissionColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
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
}
}
}
Fallback "Diffuse"
}