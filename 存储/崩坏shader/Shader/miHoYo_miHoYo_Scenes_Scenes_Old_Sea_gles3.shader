//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Sea" {
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
_Caustic ("Caustic", Float) = 1
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic Scale", Float) = 1
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_FresnelFactors ("Fresnel Factors", Vector) = (1,1,0,0)
_BloomFactor ("Bloom Factor", Float) = 1
_GlitterTex ("Glitter Tex (R: Ocean Glitter)", 2D) = "white" { }
_NoiseTex ("Noise Tex (A)", 2D) = "white" { }
[Header(Ocean Glitter)] _OceanScintillationScaleLayer1 ("Glitter Scintillation Scale Layer 1", Range(0, 50)) = 5
_OceanScintillationSpeedLayer1 ("Glitter Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_OceanScintillationScaleLayer2 ("Glitter Scintillation Scale Layer 2", Range(0, 50)) = 5
_OceanScintillationSpeedLayer2 ("Glitter Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_InnerGlitterDensity ("Inner Glitter Density", Range(0, 1)) = 0.5
_InnerGlitterBrightness ("Inner Glitter Brightness", Range(0, 1000)) = 400
_OutsideGlitterDensity ("Outside Glitter Density", Range(0, 1)) = 0.5
_OutsideGlitterBrightness ("Outside Glitter Brightness", Range(0, 1000)) = 400
_InnerDensityRange ("Inner Density Range", Range(0, 1)) = 0.2
_OceanGlitterSpeed ("Glitter Speed", Range(0, 1)) = 0.1
_OceanGlitterColor ("Glitter Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 22107
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WaterColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
mediump float u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_8.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_8.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10_8.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_12 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_8 = u_xlat10_12 * u_xlat10_8.x;
    u_xlat16_8 = u_xlat16_8 * 3.0;
    u_xlat2.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_InnerDensityRange<u_xlat2.x);
#else
    u_xlatb2 = _InnerDensityRange<u_xlat2.x;
#endif
    if(u_xlatb2){
        u_xlat10_2 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat12) * 3.0 + 1.0;
        u_xlat6.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_6 = texture(_NoiseTex, u_xlat6.xy).w;
        u_xlat16_10 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_6 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_6;
        u_xlat16_10 = float(1.0) / u_xlat16_10;
        u_xlat16_6 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
        u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
        u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
        u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
        u_xlat16_6 = u_xlat16_6 * _OutsideGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_2;
    } else {
        u_xlat10_3 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_5 = (-u_xlat12) * 3.0 + 1.0;
        u_xlat7.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_7 = texture(_NoiseTex, u_xlat7.xy).w;
        u_xlat16_11 = (-u_xlat16_5) * _InnerGlitterDensity + 1.0;
        u_xlat16_7 = (-u_xlat16_5) * _InnerGlitterDensity + u_xlat10_7;
        u_xlat16_11 = float(1.0) / u_xlat16_11;
        u_xlat16_7 = u_xlat16_11 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
        u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
        u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
        u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
        u_xlat16_6 = u_xlat16_7 * _InnerGlitterBrightness;
        u_xlat16_6 = u_xlat16_6;
        u_xlat16_1.x = u_xlat10_3;
    //ENDIF
    }
    u_xlat3.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_3 = texture(_CausticMap, u_xlat3.xy).x;
    u_xlat16_3.x = u_xlat16_1.x * u_xlat10_3;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _OceanGlitterColor.xxyz.y, u_xlat16_3.x * _OceanGlitterColor.xxyz.z, u_xlat16_3.x * float(_OceanGlitterColor.z));
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_8) + _WaterColor.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xxx;
    u_xlat16_3.xyz = vec3(_LumiFactor) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
float u_xlat11;
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
    u_xlat1 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat1.xy;
    u_xlat2 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    u_xlat4 = _Time.y * _OceanGlitterSpeed;
    u_xlat4 = u_xlat4 * _OceanScintillationSpeedLayer2;
    vs_TEXCOORD5.z = u_xlat4 * 0.200000003 + u_xlat2.z;
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat2.xyw;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat1.x);
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat6.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
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
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat12 = _Time.y * _OceanGlitterSpeed;
    u_xlat12 = u_xlat12 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat12 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	mediump vec4 _FresnelFactors;
uniform 	mediump vec2 _BumpVelocity0;
uniform 	mediump float _BumpScale0;
uniform 	mediump vec2 _BumpVelocity1;
uniform 	mediump float _BumpScale1;
uniform 	mediump vec4 _CausticVelocity;
uniform 	mediump float _CausticScale;
uniform 	vec4 _GlitterTex_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _OceanGlitterSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec2 vs_TEXCOORD7;
highp  vec4 phase0_Output0_6;
out highp vec2 vs_TEXCOORD8;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
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
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy;
    u_xlat2 = _Time.yyyy * _CausticVelocity;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * vec2(_CausticScale) + u_xlat2.xy;
    phase0_Output0_6 = in_TEXCOORD0.xyxy * _GlitterTex_ST.xyxy + u_xlat2;
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
    u_xlat16_3.x = (-u_xlat1.z) * u_xlat1.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelFactors.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelFactors.z;
    vs_TEXCOORD4.x = u_xlat16_3.x;
    vs_TEXCOORD4.z = in_COLOR0.w;
    u_xlat15 = _Time.y * _OceanGlitterSpeed;
    u_xlat15 = u_xlat15 * _OceanScintillationSpeedLayer2;
    u_xlat1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2);
    vs_TEXCOORD5.z = u_xlat15 * 0.200000003 + u_xlat1.z;
    u_xlat16_3.xyz = vec3(float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer1) * _OceanGlitterSpeed, float(_OceanScintillationSpeedLayer2) * _OceanGlitterSpeed);
    vs_TEXCOORD5.xyw = u_xlat16_3.xyz * vec3(0.400000006, 0.200000003, 0.400000006) + u_xlat1.xyw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat15) + 2.0;
    u_xlat16_3.x = u_xlat15 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat16 * u_xlat16_3.x;
    u_xlat16 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
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
vs_TEXCOORD7 = phase0_Output0_6.xy;
vs_TEXCOORD8 = phase0_Output0_6.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _RefractionColor;
uniform 	mediump float _Distortion;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _InnerGlitterDensity;
uniform 	mediump float _InnerGlitterBrightness;
uniform 	mediump float _OutsideGlitterDensity;
uniform 	mediump float _OutsideGlitterBrightness;
uniform 	mediump float _InnerDensityRange;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _CausticMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec2 vs_TEXCOORD7;
in highp vec2 vs_TEXCOORD8;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
float u_xlat17;
lowp float u_xlat10_17;
bool u_xlatb17;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat10_10.xy = texture(_NormalMap, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_10.xy + u_xlat10_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.600000024, -0.600000024);
    u_xlat16_1.xy = u_xlat16_0.xy * vec2(_Distortion);
    u_xlat0.xy = u_xlat16_1.xy / vs_TEXCOORD4.yy;
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = (-u_xlat0.xy) + u_xlat10.xy;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat10.x = vs_TEXCOORD4.z * vs_TEXCOORD4.x;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _RefColor.xyz + (-_RefractionColor.xyz);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat16_2.xyz + _RefractionColor.xyz;
    u_xlat10_10.x = texture(_NoiseTex, vs_TEXCOORD5.xy).w;
    u_xlat10_15 = texture(_NoiseTex, vs_TEXCOORD5.zw).w;
    u_xlat16_10 = u_xlat10_15 * u_xlat10_10.x;
    u_xlat16_10 = u_xlat16_10 * 3.0;
    u_xlat3.xy = vec2(vs_TEXCOORD6.x + float(-0.5), vs_TEXCOORD6.y + float(-0.5));
    u_xlat15 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat17 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(_InnerDensityRange<u_xlat17);
#else
    u_xlatb17 = _InnerDensityRange<u_xlat17;
#endif
    if(u_xlatb17){
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD8.xy).x;
        u_xlat16_1.x = (-u_xlat15) * 3.0 + 1.0;
        u_xlat3.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).w;
        u_xlat16_8 = (-u_xlat16_1.x) * _OutsideGlitterDensity + 1.0;
        u_xlat16_3 = (-u_xlat16_1.x) * _OutsideGlitterDensity + u_xlat10_3;
        u_xlat16_8 = float(1.0) / u_xlat16_8;
        u_xlat16_3 = u_xlat16_8 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_3 * -2.0 + 3.0;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
        u_xlat16_3 = u_xlat16_3 * u_xlat16_8;
        u_xlat16_3 = u_xlat16_3 * _OutsideGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    } else {
        u_xlat10_17 = texture(_GlitterTex, vs_TEXCOORD7.xy).x;
        u_xlat16_6 = (-u_xlat15) * 3.0 + 1.0;
        u_xlat4.xy = vs_TEXCOORD5.xy * vec2(10.0, 10.0);
        u_xlat10_15 = texture(_NoiseTex, u_xlat4.xy).w;
        u_xlat16_4 = (-u_xlat16_6) * _InnerGlitterDensity + 1.0;
        u_xlat16_15 = (-u_xlat16_6) * _InnerGlitterDensity + u_xlat10_15;
        u_xlat16_4 = float(1.0) / u_xlat16_4;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
        u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
        u_xlat16_4 = u_xlat16_15 * -2.0 + 3.0;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
        u_xlat16_15 = u_xlat16_15 * u_xlat16_4;
        u_xlat16_3 = u_xlat16_15 * _InnerGlitterBrightness;
        u_xlat16_3 = u_xlat16_3;
        u_xlat16_1.x = u_xlat10_17;
    //ENDIF
    }
    u_xlat0.xy = (-u_xlat0.xy) * vec2(5.0, 5.0) + vs_TEXCOORD2.xy;
    u_xlat10_0.x = texture(_CausticMap, u_xlat0.xy).x;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat10_0.x;
    u_xlat16_0.xyw = vec3(u_xlat16_0.x * _OceanGlitterColor.xxyz.y, u_xlat16_0.x * _OceanGlitterColor.xxyz.z, u_xlat16_0.x * float(_OceanGlitterColor.z));
    u_xlat16_0.xyw = vec3(u_xlat16_3) * u_xlat16_0.xyw;
    u_xlat0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_10) + u_xlat2.xyz;
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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