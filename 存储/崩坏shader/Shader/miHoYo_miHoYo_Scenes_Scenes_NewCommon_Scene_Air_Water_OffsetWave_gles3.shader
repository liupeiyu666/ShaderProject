//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_Water_OffsetWave" {
Properties {
_TextureNoise ("TextureNoise ", 2D) = "white" { }
_OffsetSpeed ("OffsetSpeed", Vector) = (0,0,0,0)
_OffsetTilling ("OffsetTilling", Vector) = (1,1,0,0)
_MainColor ("MainColor", Color) = (0.7830189,0.7830189,0.7830189,0)
_OffsetIndensity ("OffsetIndensity", Float) = 0.37
_mainMaskTexture ("mainMaskTexture", 2D) = "white" { }
_Step ("Step", Float) = 0.26
_Opacity ("Opacity", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 30838
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = vec2(in_TEXCOORD0.x * float(_OffsetTilling.x), in_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_TextureNoise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = in_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat1.xyz = textureLod(_mainMaskTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform 	float _Opacity;
uniform 	float _Step;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTilling.x), vs_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_TextureNoise, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat10_1.xyz = texture(_mainMaskTexture, u_xlat1.xy).xyz;
    u_xlat6 = u_xlat0.x * u_xlat10_1.x;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz + _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat6 * _MainColor.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Step);
#else
    u_xlatb0 = u_xlat0.x>=_Step;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = vec2(in_TEXCOORD0.x * float(_OffsetTilling.x), in_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_TextureNoise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = in_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat1.xyz = textureLod(_mainMaskTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform 	float _Opacity;
uniform 	float _Step;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTilling.x), vs_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_TextureNoise, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat10_1.xyz = texture(_mainMaskTexture, u_xlat1.xy).xyz;
    u_xlat6 = u_xlat0.x * u_xlat10_1.x;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz + _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat6 * _MainColor.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Step);
#else
    u_xlatb0 = u_xlat0.x>=_Step;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = vec2(in_TEXCOORD0.x * float(_OffsetTilling.x), in_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_TextureNoise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = in_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat1.xyz = textureLod(_mainMaskTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _OffsetSpeed;
uniform 	vec2 _OffsetTilling;
uniform 	float _OffsetIndensity;
uniform 	vec4 _mainMaskTexture_ST;
uniform 	float _Opacity;
uniform 	float _Step;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _TextureNoise;
uniform lowp sampler2D _mainMaskTexture;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTilling.x), vs_TEXCOORD0.y * float(_OffsetTilling.y));
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_TextureNoise, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_OffsetIndensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _mainMaskTexture_ST.xy + _mainMaskTexture_ST.zw;
    u_xlat10_1.xyz = texture(_mainMaskTexture, u_xlat1.xy).xyz;
    u_xlat6 = u_xlat0.x * u_xlat10_1.x;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz + _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat6 * _MainColor.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Step);
#else
    u_xlatb0 = u_xlat0.x>=_Step;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
CustomEditor "MoleMole.ShaderEditorBase"
}