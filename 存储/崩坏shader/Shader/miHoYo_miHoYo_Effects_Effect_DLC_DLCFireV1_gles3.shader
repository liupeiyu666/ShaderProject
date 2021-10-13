//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCFireV1" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
_ColorInner ("ColorInner", Color) = (1,0.753779,0.2132353,0)
_ColorOutter ("ColorOutter", Color) = (0.8970588,0.2483743,0.07915227,0)
_ShapeTexture ("ShapeTexture", 2D) = "white" { }
_ShapeBlueBrightness ("ShapeBlueBrightness", Float) = 0.8
_VcoordMultiplier ("VcoordMultiplier", Float) = 1
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_Noise1_USpeed ("Noise1_USpeed", Float) = 0
_Noise1_VSpeed ("Noise1_VSpeed", Float) = -0.9
_NoiseTex01Brightness ("NoiseTex01Brightness", Range(0, 3)) = 1.22
_NoiseTex01BrightnessAdd ("NoiseTex01BrightnessAdd", Range(0, 2)) = 0
[Toggle(_NOISEASVCOORD_ON)] _NoiseAsVcoord ("NoiseAsVcoord", Float) = 1
_OpacityIntensity ("OpacityIntensity", Float) = 1
_TimeScale ("TimeScale", Float) = 1
_GrassFireBurnOut ("GrassFireBurnOut", Float) = 0
_Alpha ("Alpha", Float) = 1
[KeywordEnum(R,G,B,A)] _Noise01ChannelToggle ("Noise01ChannelToggle", Float) = 0
[Toggle(_NOISE01_RANDOMTOGGLE_ON)] _Noise01_RandomToggle ("Noise01_RandomToggle", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 36353
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	float _Noise1_USpeed;
uniform 	float _TimeScale;
uniform 	float _Noise1_VSpeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01BrightnessAdd;
uniform 	float _OpacityIntensity;
uniform 	float _GrassFireBurnOut;
uniform 	float _Alpha;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _Noise01ChannelToggle;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	mediump float _NoiseAsVcoord;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb1;
bvec4 u_xlatb2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = _TimeScale * _Noise1_USpeed;
    u_xlat0.x = _Time.y * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat6.x = _TimeScale * _Noise1_VSpeed;
    u_xlat0.y = _Time.y * u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat6.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Noise01_RandomToggle, _NoiseAsVcoord, _Noise01_RandomToggle, _Noise01_RandomToggle)).xy;
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_Noise01ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat0.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01BrightnessAdd);
    u_xlat10_3 = texture(_ShapeTexture, vs_TEXCOORD0.xy).z;
    u_xlat3.x = u_xlat10_3 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = vs_TEXCOORD0.y * _VcoordMultiplier + (-u_xlat0.x);
    u_xlat0.y = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat6.x = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0.xyw = texture(_ShapeTexture, u_xlat0.xy).xyw;
    u_xlat3.x = u_xlat6.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat6.x = (-vs_COLOR0.w) + _GrassFireBurnOut;
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat3.x = (-u_xlat6.x) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat3.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0.xyz = u_xlat0.xyz;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	float _Noise1_USpeed;
uniform 	float _TimeScale;
uniform 	float _Noise1_VSpeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01BrightnessAdd;
uniform 	float _OpacityIntensity;
uniform 	float _GrassFireBurnOut;
uniform 	float _Alpha;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _Noise01ChannelToggle;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	mediump float _NoiseAsVcoord;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb1;
bvec4 u_xlatb2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = _TimeScale * _Noise1_USpeed;
    u_xlat0.x = _Time.y * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat6.x = _TimeScale * _Noise1_VSpeed;
    u_xlat0.y = _Time.y * u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat6.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Noise01_RandomToggle, _NoiseAsVcoord, _Noise01_RandomToggle, _Noise01_RandomToggle)).xy;
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_Noise01ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat0.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01BrightnessAdd);
    u_xlat10_3 = texture(_ShapeTexture, vs_TEXCOORD0.xy).z;
    u_xlat3.x = u_xlat10_3 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = vs_TEXCOORD0.y * _VcoordMultiplier + (-u_xlat0.x);
    u_xlat0.y = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat6.x = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0.xyw = texture(_ShapeTexture, u_xlat0.xy).xyw;
    u_xlat3.x = u_xlat6.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat6.x = (-vs_COLOR0.w) + _GrassFireBurnOut;
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat3.x = (-u_xlat6.x) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat3.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0.xyz = u_xlat0.xyz;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	float _Noise1_USpeed;
uniform 	float _TimeScale;
uniform 	float _Noise1_VSpeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01BrightnessAdd;
uniform 	float _OpacityIntensity;
uniform 	float _GrassFireBurnOut;
uniform 	float _Alpha;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _Noise01ChannelToggle;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	mediump float _NoiseAsVcoord;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb1;
bvec4 u_xlatb2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = _TimeScale * _Noise1_USpeed;
    u_xlat0.x = _Time.y * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat6.x = _TimeScale * _Noise1_VSpeed;
    u_xlat0.y = _Time.y * u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat6.xy = vec2(u_xlat0.x + vs_TEXCOORD0.z, u_xlat0.y + vs_TEXCOORD0.w);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Noise01_RandomToggle, _NoiseAsVcoord, _Noise01_RandomToggle, _Noise01_RandomToggle)).xy;
    u_xlat0.xy = (u_xlatb1.x) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat0 = texture(_NoiseTex01, u_xlat0.xy);
    u_xlatb2 = equal(vec4(_Noise01ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat0.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01BrightnessAdd);
    u_xlat10_3 = texture(_ShapeTexture, vs_TEXCOORD0.xy).z;
    u_xlat3.x = u_xlat10_3 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = vs_TEXCOORD0.y * _VcoordMultiplier + (-u_xlat0.x);
    u_xlat0.y = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat6.x = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0.xyw = texture(_ShapeTexture, u_xlat0.xy).xyw;
    u_xlat3.x = u_xlat6.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat6.x = (-vs_COLOR0.w) + _GrassFireBurnOut;
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat3.x = (-u_xlat6.x) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat3.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0.xyz = u_xlat0.xyz;
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
 Pass {
  Name "CONSTANT_MAX"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 105180
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD2.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD2.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.x = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb0.x = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD2.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD2.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.x = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb0.x = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(1.0<_TSAspectRatio);
#else
    u_xlatb1 = 1.0<_TSAspectRatio;
#endif
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + (-vs_TEXCOORD2.xy);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vec2((-vs_TEXCOORD0.x) + vs_TEXCOORD2.z, (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w);
    u_xlatb0.xy = lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    if((int(u_xlatb0.y) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.x = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb0.x = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = vs_TEXCOORD1 * _BloomFactor;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}