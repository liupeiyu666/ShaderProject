//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/MusicWave02" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_MainTexIntensity ("MainTexIntensity", Float) = 0
_MainTexOpacity ("MainTexOpacity", Float) = 1
_MainTexColor ("MainTexColor", Color) = (0,0,0,0)
_MainTexIntensityAddColor ("MainTexIntensityAddColor", Float) = 0.1
_MainOpacityTex ("MainOpacityTex", 2D) = "white" { }
_OffsetTex ("OffsetTex", 2D) = "white" { }
_OffsetTexSpeed ("OffsetTexSpeed", Vector) = (0,0,0,0)
_OffsetTexTilling ("OffsetTexTilling", Vector) = (1,1,0,0)
_OffsetTexOffset ("OffsetTexOffset", Float) = 0
_MainOffsetMaskTex ("MainOffsetMaskTex", 2D) = "white" { }
_MainOffsetMaskSpeed ("MainOffsetMaskSpeed", Vector) = (0,0,0,0)
_MainOffsetMaskOffset ("MainOffsetMaskOffset", Float) = 0
_MainOffsetMaskTilline ("MainOffsetMaskTilline", Vector) = (1,1,0,0)
_texcoord ("", 2D) = "white" { }
_ScreenClipUp ("ScreenClipUp", Float) = 0.66
_ScreenClipDown ("ScreenClipDown", Float) = 0.18
_ScreenClipWidth ("ScreenClipWidth", Float) = 0.1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 54616
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	float _MainOffsetMaskOffset;
uniform 	vec2 _OffsetTexSpeed;
uniform 	vec2 _OffsetTexTilling;
uniform 	float _OffsetTexOffset;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _OffsetTexTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_OffsetTexSpeed.x, _OffsetTexSpeed.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_OffsetTex, u_xlat0.xy, 0.0).x;
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(0.0);
    u_xlat1.xyz = u_xlat0.xyx * vec3(vec3(_OffsetTexOffset, _OffsetTexOffset, _OffsetTexOffset));
    u_xlat0.xyz = u_xlat0.zxz * u_xlat1.xyz;
    u_xlat1.xy = vec2(in_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), in_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat9 = textureLod(_MainOffsetMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat1.xyz = vec3(u_xlat9) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MainOffsetMaskOffset) * vec3(0.0, 1.0, 0.0);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	vec4 _MainTexColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOpacityTex_ST;
uniform 	float _MainTexIntensity;
uniform 	float _MainTexIntensityAddColor;
uniform 	float _MainTexOpacity;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _MainOpacityTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp float u_xlat10_1;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainTexIntensity);
    u_xlat1.xy = vec2(vs_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), vs_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat10_6 = texture(_MainOffsetMaskTex, u_xlat1.xy).x;
    u_xlat6 = u_xlat10_6 + _MainTexIntensityAddColor;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainOpacityTex_ST.xy + _MainOpacityTex_ST.zw;
    u_xlat10_1 = texture(_MainOpacityTex, u_xlat1.xy).x;
    u_xlat0.w = u_xlat10_1 * _MainTexOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	float _MainOffsetMaskOffset;
uniform 	vec2 _OffsetTexSpeed;
uniform 	vec2 _OffsetTexTilling;
uniform 	float _OffsetTexOffset;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _OffsetTexTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_OffsetTexSpeed.x, _OffsetTexSpeed.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_OffsetTex, u_xlat0.xy, 0.0).x;
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(0.0);
    u_xlat1.xyz = u_xlat0.xyx * vec3(vec3(_OffsetTexOffset, _OffsetTexOffset, _OffsetTexOffset));
    u_xlat0.xyz = u_xlat0.zxz * u_xlat1.xyz;
    u_xlat1.xy = vec2(in_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), in_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat9 = textureLod(_MainOffsetMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat1.xyz = vec3(u_xlat9) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MainOffsetMaskOffset) * vec3(0.0, 1.0, 0.0);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	vec4 _MainTexColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOpacityTex_ST;
uniform 	float _MainTexIntensity;
uniform 	float _MainTexIntensityAddColor;
uniform 	float _MainTexOpacity;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _MainOpacityTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp float u_xlat10_1;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainTexIntensity);
    u_xlat1.xy = vec2(vs_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), vs_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat10_6 = texture(_MainOffsetMaskTex, u_xlat1.xy).x;
    u_xlat6 = u_xlat10_6 + _MainTexIntensityAddColor;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainOpacityTex_ST.xy + _MainOpacityTex_ST.zw;
    u_xlat10_1 = texture(_MainOpacityTex, u_xlat1.xy).x;
    u_xlat0.w = u_xlat10_1 * _MainTexOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	float _MainOffsetMaskOffset;
uniform 	vec2 _OffsetTexSpeed;
uniform 	vec2 _OffsetTexTilling;
uniform 	float _OffsetTexOffset;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _OffsetTexTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_OffsetTexSpeed.x, _OffsetTexSpeed.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_OffsetTex, u_xlat0.xy, 0.0).x;
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(0.0);
    u_xlat1.xyz = u_xlat0.xyx * vec3(vec3(_OffsetTexOffset, _OffsetTexOffset, _OffsetTexOffset));
    u_xlat0.xyz = u_xlat0.zxz * u_xlat1.xyz;
    u_xlat1.xy = vec2(in_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), in_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat9 = textureLod(_MainOffsetMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat1.xyz = vec3(u_xlat9) * in_COLOR0.xyz;
    u_xlat2.xyz = vec3(_MainOffsetMaskOffset) * vec3(0.0, 1.0, 0.0);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _MainOffsetMaskSpeed;
uniform 	vec2 _MainOffsetMaskTilline;
uniform 	vec4 _MainTexColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainOpacityTex_ST;
uniform 	float _MainTexIntensity;
uniform 	float _MainTexIntensityAddColor;
uniform 	float _MainTexOpacity;
uniform lowp sampler2D _MainOffsetMaskTex;
uniform lowp sampler2D _MainOpacityTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp float u_xlat10_1;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_MainTexIntensity);
    u_xlat1.xy = vec2(vs_TEXCOORD1.x * float(_MainOffsetMaskTilline.x), vs_TEXCOORD1.y * float(_MainOffsetMaskTilline.y));
    u_xlat1.xy = _Time.yy * _MainOffsetMaskSpeed.xy + u_xlat1.xy;
    u_xlat10_6 = texture(_MainOffsetMaskTex, u_xlat1.xy).x;
    u_xlat6 = u_xlat10_6 + _MainTexIntensityAddColor;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _MainOpacityTex_ST.xy + _MainOpacityTex_ST.zw;
    u_xlat10_1 = texture(_MainOpacityTex, u_xlat1.xy).x;
    u_xlat0.w = u_xlat10_1 * _MainTexOpacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
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
CustomEditor "ASEMaterialInspector"
}