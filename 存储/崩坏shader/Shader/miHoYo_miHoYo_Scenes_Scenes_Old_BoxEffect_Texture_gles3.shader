//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/BoxEffect_Texture" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainMaskTexture ("MainMaskTexture", 2D) = "white" { }
_MainMaskTexture2 ("MainMaskTexture2", 2D) = "white" { }
_MaskOffset ("MaskOffset", Vector) = (0,1,0,0)
_MaskOffset2 ("MaskOffset2", Vector) = (0,1,0,0)
_MaskSpeed ("MaskSpeed", Vector) = (0,0,0,0)
_BoxColor ("BoxColor", Color) = (0,0,0,0)
_BoxColorIndensity ("BoxColorIndensity", Float) = 0
_BoxSideColor ("BoxSideColor", Color) = (0,0,0,0)
_SideColorIndensity ("SideColorIndensity", Float) = 0
_SmothStep ("SmothStep", Vector) = (0.11,-0.5,0.1,0)
_EdgeTexture ("EdgeTexture", 2D) = "white" { }
_EdgeColor ("EdgeColor", Color) = (0,0,0,0)
_EdgeIndensity ("EdgeIndensity", Float) = 0
_texcoord2 ("", 2D) = "white" { }
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_RefractTex ("Refraction Texture", Cube) = "" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 36960
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0 + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_3) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	mediump float _FogTune;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_SmothStep.x) + _SmothStep.y;
    u_xlat8 = u_xlat8 + (-_SmothStep.x);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8 = u_xlat12 * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat8) * in_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat8 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat8, u_xlat4.x);
        u_xlat1.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat8.x = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat1.xyz = u_xlat8.xxx * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD3.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
uniform 	vec3 _MaskOffset;
uniform 	vec3 _MaskOffset2;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp sampler2D _MainMaskTexture2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0 = _Time.yyyy * _MaskSpeed.zwxy;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + in_TEXCOORD0.xyxy;
    u_xlat10 = textureLod(_MainMaskTexture, u_xlat0.zw, 0.0).x;
    u_xlat0.x = textureLod(_MainMaskTexture2, u_xlat0.xy, 0.0).x;
    u_xlat0.xyw = u_xlat0.xxx * _MaskOffset2.xyz;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat10 = u_xlat10 + (-_SmothStep.x);
    u_xlat1.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat10) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MaskOffset.xxyz.y * float(0.00999999978), _MaskOffset.xxyz.z * float(0.00999999978), float(_MaskOffset.z) * float(0.00999999978));
    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD3.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4 = u_xlat0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _MaskSpeed;
uniform 	vec4 _SmothStep;
uniform 	vec4 _MainTexture_ST;
uniform 	vec4 _MainColor;
uniform 	vec4 _EdgeTexture_ST;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeIndensity;
uniform 	vec4 _BoxSideColor;
uniform 	float _SideColorIndensity;
uniform 	vec4 _BoxColor;
uniform 	float _BoxColorIndensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainMaskTexture;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _EdgeTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.100000001, 0.100000001) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainMaskTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat10_0) + 1.0;
    u_xlat0.x = u_xlat16_0.x + (-_SmothStep.x);
    u_xlat4.x = (-_SmothStep.x) + _SmothStep.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat4.xx * vs_TEXCOORD3.xz;
    u_xlat1.xyz = abs(u_xlat4.yyy) * _BoxSideColor.xyz;
    u_xlat4.xyz = _BoxSideColor.xyz * abs(u_xlat4.xxx) + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = u_xlat0.xxx * _BoxColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_BoxColorIndensity);
    u_xlat0.xyz = u_xlat4.xyz * vec3(_SideColorIndensity) + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _EdgeTexture_ST.xy + _EdgeTexture_ST.zw;
    u_xlat10_1.xyz = texture(_EdgeTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeIndensity);
    u_xlat2.xy = vs_TEXCOORD1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectionStrength) + u_xlat0.xyz;
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
    SV_Target0.w = 1.0;
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
CustomEditor "ASEMaterialInspector"
}