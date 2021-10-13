//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/UVMove_Alpha_Blended_Distortion_New" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainIntensity ("MainIntensity", Float) = 1
_MainTexture ("MainTexture", 2D) = "white" { }
_mainTexSpeed ("mainTexSpeed", Vector) = (0,0,0,0)
_MainAlphaTexture ("MainAlphaTexture ", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MainAlphaTextureChannelToggle ("MainAlphaTextureChannelToggle", Float) = 3
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_NoiseIntensity ("NoiseIntensity", Float) = 0
_texcoord ("", 2D) = "white" { }
_DisTex ("DisTex", 2D) = "white" { }
_DisMain ("DisMain", Range(0, 1)) = 0.4408133
_DisEdgeColor ("DisEdgeColor", Color) = (1,0.07075471,0.07075471,0)
_DisEdgeSoft ("DisEdgeSoft", Range(0, 1)) = 0
_DisEdgeIntensiy ("DisEdgeIntensiy", Float) = 1
_DisEdge ("DisEdge", Range(0, 2)) = 0.13
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 24344
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainAlphaTexture_ST;
uniform 	mediump float _MainAlphaTextureChannelToggle;
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	float _DisMain;
uniform 	float _DisEdgeSoft;
uniform 	vec4 _DisTex_ST;
uniform 	float _DisEdge;
uniform 	vec4 _DisEdgeColor;
uniform 	float _DisEdgeIntensiy;
uniform lowp sampler2D _MainAlphaTexture;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x + _DisMain;
    u_xlat0.x = u_xlat0.x + -0.100000001;
    u_xlat0.y = u_xlat0.x + _DisEdgeSoft;
    u_xlat0.yz = u_xlat0.yx + vec2(_DisEdge);
    u_xlat4.x = (-u_xlat0.z) + u_xlat0.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat10_12 = texture(_DisTex, u_xlat1.xy).x;
    u_xlat0.xz = (-u_xlat0.xz) + vec2(u_xlat10_12);
    u_xlat0.y = u_xlat4.x * u_xlat0.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.y = min(max(u_xlat0.y, 0.0), 1.0);
#else
    u_xlat0.y = clamp(u_xlat0.y, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.y * -2.0 + 3.0;
    u_xlat12 = float(1.0) / _DisEdgeSoft;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat4.x = (-u_xlat8) * u_xlat0.y + u_xlat0.x;
    u_xlat4.xyz = u_xlat4.xxx * _DisEdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_DisEdgeIntensiy);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NoiseSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat5.xy = _Time.yy * _mainTexSpeed.xy + u_xlat5.xy;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseIntensity) + u_xlat5.xy;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat1.xyz * vec3(_MainIntensity) + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat4.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainAlphaTexture_ST.xy + _MainAlphaTexture_ST.zw;
    u_xlat1 = texture(_MainAlphaTexture, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_MainAlphaTextureChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_Target0.w = u_xlat0.x * u_xlat16_3;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainAlphaTexture_ST;
uniform 	mediump float _MainAlphaTextureChannelToggle;
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	float _DisMain;
uniform 	float _DisEdgeSoft;
uniform 	vec4 _DisTex_ST;
uniform 	float _DisEdge;
uniform 	vec4 _DisEdgeColor;
uniform 	float _DisEdgeIntensiy;
uniform lowp sampler2D _MainAlphaTexture;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x + _DisMain;
    u_xlat0.x = u_xlat0.x + -0.100000001;
    u_xlat0.y = u_xlat0.x + _DisEdgeSoft;
    u_xlat0.yz = u_xlat0.yx + vec2(_DisEdge);
    u_xlat4.x = (-u_xlat0.z) + u_xlat0.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat10_12 = texture(_DisTex, u_xlat1.xy).x;
    u_xlat0.xz = (-u_xlat0.xz) + vec2(u_xlat10_12);
    u_xlat0.y = u_xlat4.x * u_xlat0.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.y = min(max(u_xlat0.y, 0.0), 1.0);
#else
    u_xlat0.y = clamp(u_xlat0.y, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.y * -2.0 + 3.0;
    u_xlat12 = float(1.0) / _DisEdgeSoft;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat4.x = (-u_xlat8) * u_xlat0.y + u_xlat0.x;
    u_xlat4.xyz = u_xlat4.xxx * _DisEdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_DisEdgeIntensiy);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NoiseSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat5.xy = _Time.yy * _mainTexSpeed.xy + u_xlat5.xy;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseIntensity) + u_xlat5.xy;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat1.xyz * vec3(_MainIntensity) + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat4.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainAlphaTexture_ST.xy + _MainAlphaTexture_ST.zw;
    u_xlat1 = texture(_MainAlphaTexture, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_MainAlphaTextureChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_Target0.w = u_xlat0.x * u_xlat16_3;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainAlphaTexture_ST;
uniform 	mediump float _MainAlphaTextureChannelToggle;
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	float _DisMain;
uniform 	float _DisEdgeSoft;
uniform 	vec4 _DisTex_ST;
uniform 	float _DisEdge;
uniform 	vec4 _DisEdgeColor;
uniform 	float _DisEdgeIntensiy;
uniform lowp sampler2D _MainAlphaTexture;
uniform lowp sampler2D _DisTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x + _DisMain;
    u_xlat0.x = u_xlat0.x + -0.100000001;
    u_xlat0.y = u_xlat0.x + _DisEdgeSoft;
    u_xlat0.yz = u_xlat0.yx + vec2(_DisEdge);
    u_xlat4.x = (-u_xlat0.z) + u_xlat0.y;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DisTex_ST.xy + _DisTex_ST.zw;
    u_xlat10_12 = texture(_DisTex, u_xlat1.xy).x;
    u_xlat0.xz = (-u_xlat0.xz) + vec2(u_xlat10_12);
    u_xlat0.y = u_xlat4.x * u_xlat0.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.y = min(max(u_xlat0.y, 0.0), 1.0);
#else
    u_xlat0.y = clamp(u_xlat0.y, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.y * -2.0 + 3.0;
    u_xlat12 = float(1.0) / _DisEdgeSoft;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat4.x = (-u_xlat8) * u_xlat0.y + u_xlat0.x;
    u_xlat4.xyz = u_xlat4.xxx * _DisEdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_DisEdgeIntensiy);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NoiseSpeed.xy + u_xlat1.xy;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat5.xy = _Time.yy * _mainTexSpeed.xy + u_xlat5.xy;
    u_xlat1.xy = u_xlat10_1.xx * vec2(_NoiseIntensity) + u_xlat5.xy;
    u_xlat10_1.xyz = texture(_MainTexture, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat1.xyz * vec3(_MainIntensity) + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat4.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainAlphaTexture_ST.xy + _MainAlphaTexture_ST.zw;
    u_xlat1 = texture(_MainAlphaTexture, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_MainAlphaTextureChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3;
    SV_Target0.w = u_xlat0.x * u_xlat16_3;
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
CustomEditor "MoleMole.ParticleShaderEditorBase"
}