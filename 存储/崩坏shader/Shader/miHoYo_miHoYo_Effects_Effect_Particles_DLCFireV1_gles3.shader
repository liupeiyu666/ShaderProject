//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCFireV1" {
Properties {
_ColorInner ("ColorInner", Color) = (1,0.753779,0.2132353,0)
_InnerColorIntensity ("InnerColorIntensity", Float) = 1
_ColorOutter ("ColorOutter", Color) = (0.8970588,0.2483743,0.07915227,0)
_OutColorIntensity ("OutColorIntensity", Float) = 1
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
[Toggle(_NOISE01_RANDOMTOGGLE_ON)] _Noise01_RandomToggle ("Noise01_RandomToggle", Float) = 0
[KeywordEnum(R,G,B,A)] _Noise01ChannelToggle ("Noise01ChannelToggle", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 53649
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
uniform 	mediump float _LumiFactor;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vs_COLOR0.yyy + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
uniform 	mediump float _LumiFactor;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vs_COLOR0.yyy + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _ColorOutter;
uniform 	float _OutColorIntensity;
uniform 	vec4 _ColorInner;
uniform 	float _InnerColorIntensity;
uniform 	mediump float _LumiFactor;
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
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
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
    u_xlatb2 = equal(vec4(vec4(_Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle, _Noise01ChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
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
    u_xlat1.w = u_xlat3.x * vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorOutter.xyz * vec3(_OutColorIntensity);
    u_xlat2.xyz = _ColorInner.xyz * vec3(_InnerColorIntensity) + (-u_xlat3.xyz);
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat9 = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vs_COLOR0.yyy + vec3(u_xlat9);
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}