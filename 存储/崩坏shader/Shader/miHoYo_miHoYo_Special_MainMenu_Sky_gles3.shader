//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Sky" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_TexRColor ("Texture Color For R Channel", Color) = (1,1,1,1)
_TexGColor ("Texture Color For G Channel", Color) = (1,1,1,1)
_TexBColor ("Texture Color For B Channel", Color) = (1,1,1,1)
_TexXLocation ("Texture Location X", Range(0, 1)) = 0
_TexYLocation ("Texture Location Y", Range(0, 1)) = 0.5
_TexHigh ("Texture High", Range(0.01, 1)) = 1
_SecTex ("Second Texture", 2D) = "white" { }
_SecTexXLocation ("Second Texture Location X", Range(0, 1)) = 0
_SecTexYLocation ("Second Texture Location Y", Range(0, 1)) = 0.5
_SecTexHigh ("Second Texture High", Range(0.01, 1)) = 1
_SecTexEmission ("Second Texture Emission", Range(0, 10)) = 1
_GradBottomColor ("Gradiant Bottom Color", Color) = (1,1,1,1)
_GradTopColor ("Gradiant Top Color", Color) = (1,1,1,1)
_GradLocation ("Gradiant Location", Range(-5, 1)) = 0
_GradHigh ("Gradiant High", Range(0.01, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 3236
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _TexXLocation;
uniform 	float _TexYLocation;
uniform 	float _TexHigh;
uniform 	float _SecTexXLocation;
uniform 	float _SecTexYLocation;
uniform 	float _SecTexHigh;
uniform 	float _GradLocation;
uniform 	float _GradHigh;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat0.xz = in_TEXCOORD0.xx + vec2(_TexXLocation, _SecTexXLocation);
    u_xlat0.y = in_TEXCOORD0.y + (-_TexYLocation);
    vs_TEXCOORD0.xy = u_xlat0.xy / vec2(vec2(_TexHigh, _TexHigh));
    u_xlat0.w = in_TEXCOORD0.y + (-_SecTexYLocation);
    vs_TEXCOORD0.zw = vec2(u_xlat0.z / float(_SecTexHigh), u_xlat0.w / float(_SecTexHigh));
    u_xlat0.x = in_TEXCOORD0.y + _GradLocation;
    vs_TEXCOORD1 = u_xlat0.x / _GradHigh;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _SecTexEmission;
uniform 	mediump vec4 _GradBottomColor;
uniform 	mediump vec4 _GradTopColor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat14;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xy = vec2((-vs_TEXCOORD0.w) + float(1.0), (-vs_TEXCOORD0.y) + float(1.0));
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlati0.xy = ivec2(u_xlat0.xy);
    u_xlat14.xy = floor(vs_TEXCOORD0.wy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati0.zw = ivec2(u_xlat14.xy);
    u_xlatb0 = equal(u_xlati0, ivec4(0, 0, 0, 0));
    u_xlatb0.x = u_xlatb0.z && u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w && u_xlatb0.y;
    u_xlat14.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-_GradBottomColor.xyz) + _GradTopColor.xyz;
    u_xlat1.xyz = u_xlat14.xxx * u_xlat16_1.xyz + _GradBottomColor.xyz;
    u_xlat10_2.xyz = texture(_SecTex, vs_TEXCOORD0.zw).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SecTexEmission, _SecTexEmission, _SecTexEmission)) + u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TexRColor.xyz;
    u_xlat10_0.xzw = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_24 = u_xlat10_0.x * _TexRColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _TexGColor.xyz;
    u_xlat16_24 = u_xlat10_0.z * _TexGColor.w;
    u_xlat16_6.xyz = u_xlat10_0.www * _TexBColor.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb0.y) ? u_xlat16_4.xyz : u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	float _TexXLocation;
uniform 	float _TexYLocation;
uniform 	float _TexHigh;
uniform 	float _SecTexXLocation;
uniform 	float _SecTexYLocation;
uniform 	float _SecTexHigh;
uniform 	float _GradLocation;
uniform 	float _GradHigh;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat0.xz = in_TEXCOORD0.xx + vec2(_TexXLocation, _SecTexXLocation);
    u_xlat0.y = in_TEXCOORD0.y + (-_TexYLocation);
    vs_TEXCOORD0.xy = u_xlat0.xy / vec2(vec2(_TexHigh, _TexHigh));
    u_xlat0.w = in_TEXCOORD0.y + (-_SecTexYLocation);
    vs_TEXCOORD0.zw = vec2(u_xlat0.z / float(_SecTexHigh), u_xlat0.w / float(_SecTexHigh));
    u_xlat0.x = in_TEXCOORD0.y + _GradLocation;
    vs_TEXCOORD1 = u_xlat0.x / _GradHigh;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _SecTexEmission;
uniform 	mediump vec4 _GradBottomColor;
uniform 	mediump vec4 _GradTopColor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat14;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xy = vec2((-vs_TEXCOORD0.w) + float(1.0), (-vs_TEXCOORD0.y) + float(1.0));
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlati0.xy = ivec2(u_xlat0.xy);
    u_xlat14.xy = floor(vs_TEXCOORD0.wy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati0.zw = ivec2(u_xlat14.xy);
    u_xlatb0 = equal(u_xlati0, ivec4(0, 0, 0, 0));
    u_xlatb0.x = u_xlatb0.z && u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w && u_xlatb0.y;
    u_xlat14.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-_GradBottomColor.xyz) + _GradTopColor.xyz;
    u_xlat1.xyz = u_xlat14.xxx * u_xlat16_1.xyz + _GradBottomColor.xyz;
    u_xlat10_2.xyz = texture(_SecTex, vs_TEXCOORD0.zw).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SecTexEmission, _SecTexEmission, _SecTexEmission)) + u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TexRColor.xyz;
    u_xlat10_0.xzw = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_24 = u_xlat10_0.x * _TexRColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _TexGColor.xyz;
    u_xlat16_24 = u_xlat10_0.z * _TexGColor.w;
    u_xlat16_6.xyz = u_xlat10_0.www * _TexBColor.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb0.y) ? u_xlat16_4.xyz : u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	float _TexXLocation;
uniform 	float _TexYLocation;
uniform 	float _TexHigh;
uniform 	float _SecTexXLocation;
uniform 	float _SecTexYLocation;
uniform 	float _SecTexHigh;
uniform 	float _GradLocation;
uniform 	float _GradHigh;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    u_xlat0.xz = in_TEXCOORD0.xx + vec2(_TexXLocation, _SecTexXLocation);
    u_xlat0.y = in_TEXCOORD0.y + (-_TexYLocation);
    vs_TEXCOORD0.xy = u_xlat0.xy / vec2(vec2(_TexHigh, _TexHigh));
    u_xlat0.w = in_TEXCOORD0.y + (-_SecTexYLocation);
    vs_TEXCOORD0.zw = vec2(u_xlat0.z / float(_SecTexHigh), u_xlat0.w / float(_SecTexHigh));
    u_xlat0.x = in_TEXCOORD0.y + _GradLocation;
    vs_TEXCOORD1 = u_xlat0.x / _GradHigh;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor;
uniform 	mediump vec4 _TexGColor;
uniform 	mediump vec4 _TexBColor;
uniform 	float _SecTexEmission;
uniform 	mediump vec4 _GradBottomColor;
uniform 	mediump vec4 _GradTopColor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
ivec4 u_xlati0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat14;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xy = vec2((-vs_TEXCOORD0.w) + float(1.0), (-vs_TEXCOORD0.y) + float(1.0));
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlati0.xy = ivec2(u_xlat0.xy);
    u_xlat14.xy = floor(vs_TEXCOORD0.wy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati0.zw = ivec2(u_xlat14.xy);
    u_xlatb0 = equal(u_xlati0, ivec4(0, 0, 0, 0));
    u_xlatb0.x = u_xlatb0.z && u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w && u_xlatb0.y;
    u_xlat14.x = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-_GradBottomColor.xyz) + _GradTopColor.xyz;
    u_xlat1.xyz = u_xlat14.xxx * u_xlat16_1.xyz + _GradBottomColor.xyz;
    u_xlat10_2.xyz = texture(_SecTex, vs_TEXCOORD0.zw).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SecTexEmission, _SecTexEmission, _SecTexEmission)) + u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _TexRColor.xyz;
    u_xlat10_0.xzw = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_24 = u_xlat10_0.x * _TexRColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _TexGColor.xyz;
    u_xlat16_24 = u_xlat10_0.z * _TexGColor.w;
    u_xlat16_6.xyz = u_xlat10_0.www * _TexBColor.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb0.y) ? u_xlat16_4.xyz : u_xlat16_3.xyz;
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
}
}
}
}