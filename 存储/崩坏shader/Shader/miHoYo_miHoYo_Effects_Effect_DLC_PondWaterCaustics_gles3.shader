//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/PondWaterCaustics" {
Properties {
[Header(Caustics)] _CausticTex ("CausticTex", 2D) = "white" { }
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticTiling ("CausticTiling", Range(0, 2)) = 0.3
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 20)) = 1.2
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 0.3)) = 0.03
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.348
_CausticFade ("CausticFade", Range(0.01, 1)) = 0.837
_CausticFadeMinHeight ("CausticFadeMinHeight", Range(-200, 200)) = -145
_CausticFadeMaxHeight ("CausticFadeMaxHeight", Range(-200, 200)) = -13
_CausticFadeRange ("CausticFadeRange", Range(0, 10)) = 4.88
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 26108
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadeRange;
uniform 	float _CausticFadeMinHeight;
uniform 	float _CausticFadeMaxHeight;
uniform lowp sampler2D _CausticTex;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0 = _CausticFadeRange + _CausticFadeMaxHeight;
    u_xlat3.x = (-u_xlat0) + _CausticFadeMaxHeight;
    u_xlat0 = (-u_xlat0) + vs_TEXCOORD1.y;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = u_xlat0 * _CausticFade;
    u_xlat3.x = (-_CausticFadeRange) + _CausticFadeMinHeight;
    u_xlat6.x = (-u_xlat3.x) + _CausticFadeMinHeight;
    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD1.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3.x = u_xlat6.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat6.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
    u_xlat3.x = _Time.x * _CausticDistortionSpeed;
    u_xlat1 = vec4(_CausticDistortionTiling, _CausticDistortionTiling, _CausticTiling, _CausticTiling) * vec4(200.0, 200.0, 100.0, 100.0);
    u_xlat2 = u_xlat1 * vs_TEXCOORD0.xyxy;
    u_xlat6.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat3.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(1.5, 1.5) + (-u_xlat3.xx);
    u_xlat10_1.xy = texture(_CausticTex, u_xlat1.xy).yz;
    u_xlat10_3.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_1.xy = (-u_xlat10_3.xy) + u_xlat10_1.xy;
    u_xlat16_3.xy = u_xlat16_1.xy * vec2(0.600000024, 0.600000024) + u_xlat10_3.xy;
    u_xlat3.xy = vec2(vec2(_CausticDistortionValue, _CausticDistortionValue)) * u_xlat16_3.xy + u_xlat2.zw;
    u_xlat10_3.x = texture(_CausticTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CausticIntensity;
    u_xlat3.xyz = u_xlat3.xxx * _CausticColor.xyz;
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadeRange;
uniform 	float _CausticFadeMinHeight;
uniform 	float _CausticFadeMaxHeight;
uniform lowp sampler2D _CausticTex;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0 = _CausticFadeRange + _CausticFadeMaxHeight;
    u_xlat3.x = (-u_xlat0) + _CausticFadeMaxHeight;
    u_xlat0 = (-u_xlat0) + vs_TEXCOORD1.y;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = u_xlat0 * _CausticFade;
    u_xlat3.x = (-_CausticFadeRange) + _CausticFadeMinHeight;
    u_xlat6.x = (-u_xlat3.x) + _CausticFadeMinHeight;
    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD1.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3.x = u_xlat6.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat6.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
    u_xlat3.x = _Time.x * _CausticDistortionSpeed;
    u_xlat1 = vec4(_CausticDistortionTiling, _CausticDistortionTiling, _CausticTiling, _CausticTiling) * vec4(200.0, 200.0, 100.0, 100.0);
    u_xlat2 = u_xlat1 * vs_TEXCOORD0.xyxy;
    u_xlat6.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat3.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(1.5, 1.5) + (-u_xlat3.xx);
    u_xlat10_1.xy = texture(_CausticTex, u_xlat1.xy).yz;
    u_xlat10_3.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_1.xy = (-u_xlat10_3.xy) + u_xlat10_1.xy;
    u_xlat16_3.xy = u_xlat16_1.xy * vec2(0.600000024, 0.600000024) + u_xlat10_3.xy;
    u_xlat3.xy = vec2(vec2(_CausticDistortionValue, _CausticDistortionValue)) * u_xlat16_3.xy + u_xlat2.zw;
    u_xlat10_3.x = texture(_CausticTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CausticIntensity;
    u_xlat3.xyz = u_xlat3.xxx * _CausticColor.xyz;
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticFade;
uniform 	float _CausticFadeRange;
uniform 	float _CausticFadeMinHeight;
uniform 	float _CausticFadeMaxHeight;
uniform lowp sampler2D _CausticTex;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0 = _CausticFadeRange + _CausticFadeMaxHeight;
    u_xlat3.x = (-u_xlat0) + _CausticFadeMaxHeight;
    u_xlat0 = (-u_xlat0) + vs_TEXCOORD1.y;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = u_xlat0 * _CausticFade;
    u_xlat3.x = (-_CausticFadeRange) + _CausticFadeMinHeight;
    u_xlat6.x = (-u_xlat3.x) + _CausticFadeMinHeight;
    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD1.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3.x = u_xlat6.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat6.x;
    u_xlat0 = u_xlat3.x * u_xlat0;
    u_xlat3.x = _Time.x * _CausticDistortionSpeed;
    u_xlat1 = vec4(_CausticDistortionTiling, _CausticDistortionTiling, _CausticTiling, _CausticTiling) * vec4(200.0, 200.0, 100.0, 100.0);
    u_xlat2 = u_xlat1 * vs_TEXCOORD0.xyxy;
    u_xlat6.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat3.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(1.5, 1.5) + (-u_xlat3.xx);
    u_xlat10_1.xy = texture(_CausticTex, u_xlat1.xy).yz;
    u_xlat10_3.xy = texture(_CausticTex, u_xlat6.xy).yz;
    u_xlat16_1.xy = (-u_xlat10_3.xy) + u_xlat10_1.xy;
    u_xlat16_3.xy = u_xlat16_1.xy * vec2(0.600000024, 0.600000024) + u_xlat10_3.xy;
    u_xlat3.xy = vec2(vec2(_CausticDistortionValue, _CausticDistortionValue)) * u_xlat16_3.xy + u_xlat2.zw;
    u_xlat10_3.x = texture(_CausticTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CausticIntensity;
    u_xlat3.xyz = u_xlat3.xxx * _CausticColor.xyz;
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat3.xyz;
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}