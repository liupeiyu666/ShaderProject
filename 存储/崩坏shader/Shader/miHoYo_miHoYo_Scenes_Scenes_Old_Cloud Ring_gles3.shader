//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Cloud Ring" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_AspectRatio ("Aspect Ratio", Float) = 1
_TexRColor ("Texture Color For R Channel", Color) = (1,1,1,1)
_TexGColor ("Texture Color For G Channel", Color) = (1,1,1,1)
_TexBColor ("Texture Color For B Channel", Color) = (1,1,1,1)
_CloudMaskIntensity ("Cloud Mask Intensity", Range(0, 1)) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_GradFrontColor ("Gradiant Front Color", Color) = (1,1,1,1)
_GradBackColor ("Gradiant Back Color", Color) = (1,1,1,1)
_GradLocationY ("Gradiant LocationY", Range(-5, 1)) = 0
_GradHighY ("Gradiant HighY", Range(0.01, 10)) = 1
_GradLocationRotateX ("Gradiant Location RotateX", Range(-1, 1)) = 0
_GradLocationX ("Gradiant LocationX", Range(-5, 1)) = 0
_GradHighX ("Gradiant HighX", Range(0.01, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry-1" "RenderType" = "Transparent" }
  ZTest Always
  Cull Off
  GpuProgramID 42486
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.x = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat6.x / _GradHighX;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat12 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat12 / _GradHighX;
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
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColDelta.w);
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
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat12 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat12 / _GradHighX;
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
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColDelta.w);
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
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat12 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat12 / _GradHighX;
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
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColDelta.w);
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
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat15 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat15 / _GradHighX;
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
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
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
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
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
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
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
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat15 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat15 / _GradHighX;
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
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
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
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
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
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
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
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _GradLocationX;
uniform 	float _GradHighX;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat15 = in_TEXCOORD1.x + _GradLocationX;
    vs_TEXCOORD1 = u_xlat15 / _GradHighX;
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
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
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
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
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
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
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
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
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
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _CloudMaskIntensity;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x + -1.0;
    u_xlat5 = _CloudMaskIntensity * u_xlat5 + 1.0;
    u_xlat16_1.xyz = _GradBackColor.xyz * vec3(2.0, 2.0, 2.0) + (-_GradFrontColor.xyz);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat16_1.xyz + _GradFrontColor.xyz;
    u_xlat16_16 = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = _TexRColor.xyz * vec3(u_xlat5) + (-u_xlat16_1.xyz);
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.x = u_xlat10_2.x * _TexRColor.w;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _TexGColor.xyz * u_xlat16_1.xyz + (-u_xlat0.xyz);
    u_xlat16_3.x = u_xlat10_2.y * _TexGColor.w;
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_2.zzz * _TexBColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TexBColor.www;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _TexBColor.www * _TexBColor.xyz;
    u_xlat16_3.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
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