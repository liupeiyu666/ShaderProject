//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/FireShell" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler To Add", Range(1, 100)) = 1
_NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseScaler ("Noise Scaler", Range(0, 10)) = 1
_Transition ("Transition", Range(0, 1)) = 0
_Width ("Width", Range(0, 1)) = 0.2
_ClipWidth ("Clip Width (along z)", Range(-5, 5)) = 0.2
_ClipOffset ("Clip Offset (along z)", Range(-5, 5)) = 0
_FresnelParams ("Fresnel", Vector) = (1,0,0,0)
_Displacement ("Displacement", Range(0, 0.1)) = 0
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 22130
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * vec3(vec3(_Displacement, _Displacement, _Displacement)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xzz * vec3(0.5, 0.5, 0.100000001);
    u_xlat9 = u_xlat0.y * 0.5 + (-u_xlat1.z);
    u_xlat7.xy = u_xlat0.zx * u_xlat1.yx;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * u_xlat1.y + u_xlat1.x;
    u_xlat6 = (-u_xlat7.x) * 0.349999994 + u_xlat9;
    u_xlat0.y = u_xlat7.y * 0.75 + u_xlat6;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _ClipWidth;
uniform 	float _ClipOffset;
uniform 	float _Width;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _NoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
float u_xlat5;
void main()
{
    u_xlat16_0 = -abs(vs_TEXCOORD2.y) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.x;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.y;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + _FresnelParams.z;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1.x = vs_TEXCOORD1.z + (-_ClipOffset);
    u_xlat1.x = u_xlat1.x / _ClipWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat1.x;
    u_xlat1.x = _Width * u_xlat16_0 + 1.5;
    u_xlat10_3 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_3 * 1.99000001;
    u_xlat3 = u_xlat16_0 * _NoiseScaler + -1.0;
    u_xlat5 = _NoiseScaler * _Transition;
    u_xlat1.x = u_xlat1.x * u_xlat5 + (-u_xlat3);
    u_xlat3 = u_xlat5 * 1.5 + (-u_xlat3);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = max(u_xlat3, 0.0);
    u_xlati3 = int(u_xlat3);
    u_xlat0.w = u_xlat1.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = _Color.xyz * vec3(_EmissionScaler);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xzw;
    SV_Target0 = (int(u_xlati3) != 0) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * vec3(vec3(_Displacement, _Displacement, _Displacement)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xzz * vec3(0.5, 0.5, 0.100000001);
    u_xlat9 = u_xlat0.y * 0.5 + (-u_xlat1.z);
    u_xlat7.xy = u_xlat0.zx * u_xlat1.yx;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * u_xlat1.y + u_xlat1.x;
    u_xlat6 = (-u_xlat7.x) * 0.349999994 + u_xlat9;
    u_xlat0.y = u_xlat7.y * 0.75 + u_xlat6;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _ClipWidth;
uniform 	float _ClipOffset;
uniform 	float _Width;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _NoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
float u_xlat5;
void main()
{
    u_xlat16_0 = -abs(vs_TEXCOORD2.y) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.x;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.y;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + _FresnelParams.z;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1.x = vs_TEXCOORD1.z + (-_ClipOffset);
    u_xlat1.x = u_xlat1.x / _ClipWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat1.x;
    u_xlat1.x = _Width * u_xlat16_0 + 1.5;
    u_xlat10_3 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_3 * 1.99000001;
    u_xlat3 = u_xlat16_0 * _NoiseScaler + -1.0;
    u_xlat5 = _NoiseScaler * _Transition;
    u_xlat1.x = u_xlat1.x * u_xlat5 + (-u_xlat3);
    u_xlat3 = u_xlat5 * 1.5 + (-u_xlat3);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = max(u_xlat3, 0.0);
    u_xlati3 = int(u_xlat3);
    u_xlat0.w = u_xlat1.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = _Color.xyz * vec3(_EmissionScaler);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xzw;
    SV_Target0 = (int(u_xlati3) != 0) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * vec3(vec3(_Displacement, _Displacement, _Displacement)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xzz * vec3(0.5, 0.5, 0.100000001);
    u_xlat9 = u_xlat0.y * 0.5 + (-u_xlat1.z);
    u_xlat7.xy = u_xlat0.zx * u_xlat1.yx;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * u_xlat1.y + u_xlat1.x;
    u_xlat6 = (-u_xlat7.x) * 0.349999994 + u_xlat9;
    u_xlat0.y = u_xlat7.y * 0.75 + u_xlat6;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _ClipWidth;
uniform 	float _ClipOffset;
uniform 	float _Width;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _NoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
float u_xlat5;
void main()
{
    u_xlat16_0 = -abs(vs_TEXCOORD2.y) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.x;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _FresnelParams.y;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + _FresnelParams.z;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat1.x = vs_TEXCOORD1.z + (-_ClipOffset);
    u_xlat1.x = u_xlat1.x / _ClipWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat1.x;
    u_xlat1.x = _Width * u_xlat16_0 + 1.5;
    u_xlat10_3 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat10_3 * 1.99000001;
    u_xlat3 = u_xlat16_0 * _NoiseScaler + -1.0;
    u_xlat5 = _NoiseScaler * _Transition;
    u_xlat1.x = u_xlat1.x * u_xlat5 + (-u_xlat3);
    u_xlat3 = u_xlat5 * 1.5 + (-u_xlat3);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = max(u_xlat3, 0.0);
    u_xlati3 = int(u_xlat3);
    u_xlat0.w = u_xlat1.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = _Color.xyz * vec3(_EmissionScaler);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xzw;
    SV_Target0 = (int(u_xlati3) != 0) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}