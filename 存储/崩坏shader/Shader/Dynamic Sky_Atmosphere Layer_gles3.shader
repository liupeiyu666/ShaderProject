//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Atmosphere Layer" {
Properties {
_SkyGradientTex ("Sky Gradient Tex", 2D) = "white" { }
_StarsTex ("Stars (Alpha)", 2D) = "white" { }
_StarsColorPalette ("Stars Color Palette", 2D) = "white" { }
_NoiseTex ("Noise Tex (Alpha)", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 18576
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump vec2 u_xlat16_12;
bool u_xlatb12;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = u_xlat0.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat18 = _Time.y * _ES_StarsScintillation;
    u_xlat2 = vec4(u_xlat18) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.xy * vec2(2.0, 2.0) + u_xlat2.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat2.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat0.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat6 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb12 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat6 = sqrt(u_xlat6);
    u_xlat18 = u_xlat6 * u_xlat0.x;
    u_xlat18 = u_xlat18 * -2.0 + 3.14159274;
    u_xlat12 = u_xlatb12 ? u_xlat18 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat12;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_3.x;
    u_xlat16_15 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_15 = u_xlat16_15 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 * -2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21;
    u_xlat16_9.z = u_xlat16_9.x * 0.5 + 0.5;
    u_xlat16_9.x = u_xlat16_9.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.xz = max(u_xlat16_9.xz, vec2(0.0, 0.0));
    u_xlat16_21 = u_xlat16_9.z + -0.300000012;
    u_xlat16_21 = u_xlat16_21 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_21 * -2.0 + 3.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_10 = u_xlat16_21 * u_xlat16_4.x;
    u_xlat16_21 = (-u_xlat16_4.x) * u_xlat16_21 + 1.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_21 + u_xlat16_10;
    u_xlat16_21 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_12.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat16_0.y = float(0.5);
    u_xlat16_12.y = float(0.5);
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_12.xy, 0.0).y;
    u_xlat16_4.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz;
    u_xlat16_21 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_0.x = abs(u_xlat16_3.x) / u_xlat16_21;
    u_xlat1.x = textureLod(_SkyGradientTex, u_xlat16_0.xy, 0.0).x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_0.w = u_xlat16_9.x * u_xlat16_3.x;
    u_xlat16_3.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_3.xyw = u_xlat16_0.www * u_xlat16_3.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_5.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz + _ES_TopBackColor.xyz;
    u_xlat16_3.xyw = u_xlat16_3.xyw + (-u_xlat16_5.xyz);
    u_xlat16_3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_3.xyw;
    vs_TEXCOORD4 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat7 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat23 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColDelta.w);
    u_xlat2.xyz = u_xlat14.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat7 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat1.w = u_xlat7 * u_xlat14.x;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat7 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat23 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColDelta.w);
    u_xlat2.xyz = u_xlat14.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat7 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat1.w = u_xlat7 * u_xlat14.x;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat7 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat14.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat23 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColDelta.w);
    u_xlat2.xyz = u_xlat14.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat7 * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_4.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat7 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta.w);
    u_xlat7 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat1.w = u_xlat7 * u_xlat14.x;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
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
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat23 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColDelta3.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat23 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat23 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_4.x = (u_xlatb23) ? u_xlat10.x : 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_11.x = (-u_xlat23) + 2.0;
    u_xlat16_11.x = u_xlat23 * u_xlat16_11.x;
    u_xlat23 = u_xlat16_11.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat23 = min(u_xlat16_4.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat1.w = u_xlat21 * u_xlat10.x;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat16_4.x = (-u_xlat7.x) + 2.0;
    u_xlat16_4.x = u_xlat7.x * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColDelta2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat14 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
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
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat23 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColDelta3.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat23 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat23 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_4.x = (u_xlatb23) ? u_xlat10.x : 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_11.x = (-u_xlat23) + 2.0;
    u_xlat16_11.x = u_xlat23 * u_xlat16_11.x;
    u_xlat23 = u_xlat16_11.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat23 = min(u_xlat16_4.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat1.w = u_xlat21 * u_xlat10.x;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat16_4.x = (-u_xlat7.x) + 2.0;
    u_xlat16_4.x = u_xlat7.x * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColDelta2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat14 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec4 _ES_TopFrontColor;
uniform 	mediump vec4 _ES_TopBackColor;
uniform 	mediump vec4 _ES_BottomFrontColor;
uniform 	mediump vec4 _ES_BottomBackColor;
uniform 	mediump float _ES_SkyFrontAndBackBlendFactor;
uniform 	mediump float _ES_BottomColorHeight;
uniform 	mediump vec3 _ES_HorizonHaloColor;
uniform 	mediump float _ES_HorizonHaloIntensity;
uniform 	mediump float _ES_HorizonHaloHeight;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	float _ES_StarsScintillation;
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
uniform 	vec4 _StarsTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform lowp sampler2D _SkyGradientTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
mediump vec2 u_xlat16_15;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _StarsTex_ST.xy + _StarsTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(20.0, 20.0);
    u_xlat2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy;
    u_xlat21 = _Time.y * _ES_StarsScintillation;
    u_xlat3 = vec4(u_xlat21) * vec4(0.400000006, 0.200000003, 0.100000001, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.xy * vec2(2.0, 2.0) + u_xlat3.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + u_xlat3.xy;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_4.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat16_11.x = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat21 = abs(u_xlat16_4.x) * -0.0187292993 + 0.0742610022;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + -0.212114394;
    u_xlat21 = u_xlat21 * abs(u_xlat16_4.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_4.x<(-u_xlat16_4.x));
#else
    u_xlatb8 = u_xlat16_4.x<(-u_xlat16_4.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat21 * u_xlat1.x;
    u_xlat15 = u_xlat15 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat15 : float(0.0);
    u_xlat21 = u_xlat21 * u_xlat1.x + u_xlat8;
    u_xlat21 = (-u_xlat21) + 1.57079637;
    u_xlat16_4.x = u_xlat21 * 0.636619806;
    vs_TEXCOORD3.w = u_xlat16_4.x;
    u_xlat16_18 = abs(_ES_SunDirection.xxyz.z) + -0.200000003;
    u_xlat16_18 = u_xlat16_18 * 3.33333325;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_18 * -2.0 + 3.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25;
    u_xlat16_11.z = u_xlat16_11.x * 0.5 + 0.5;
    u_xlat16_11.x = u_xlat16_11.x * _ES_SkyFrontAndBackBlendFactor + (-_ES_SkyFrontAndBackBlendFactor);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.xz = max(u_xlat16_11.xz, vec2(0.0, 0.0));
    u_xlat16_25 = u_xlat16_11.z + -0.300000012;
    u_xlat16_25 = u_xlat16_25 * 1.42857146;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_25 * -2.0 + 3.0;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_12 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_25 = (-u_xlat16_5.x) * u_xlat16_25 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = max(_ES_HorizonHaloHeight, 9.99999975e-05);
    u_xlat16_15.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat16_1.y = float(0.5);
    u_xlat16_15.y = float(0.5);
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_15.xy, 0.0).y;
    u_xlat16_5.xyz = vec3(_ES_HorizonHaloColor.xxyz.y * _ES_HorizonHaloIntensity, _ES_HorizonHaloColor.xxyz.z * _ES_HorizonHaloIntensity, float(_ES_HorizonHaloColor.z) * _ES_HorizonHaloIntensity);
    u_xlat16_5.xyz = vec3(u_xlat21) * u_xlat16_5.xyz;
    u_xlat16_25 = max(_ES_BottomColorHeight, 9.99999975e-05);
    u_xlat16_1.x = abs(u_xlat16_4.x) / u_xlat16_25;
    u_xlat21 = textureLod(_SkyGradientTex, u_xlat16_1.xy, 0.0).x;
    u_xlat16_4.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_1.w = u_xlat16_11.x * u_xlat16_4.x;
    u_xlat16_4.xyw = _ES_BottomFrontColor.xyz + (-_ES_BottomBackColor.xyz);
    u_xlat16_4.xyw = u_xlat16_1.www * u_xlat16_4.xyw + _ES_BottomBackColor.xyz;
    u_xlat16_6.xyz = _ES_TopFrontColor.xyz + (-_ES_TopBackColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_6.xyz + _ES_TopBackColor.xyz;
    u_xlat16_4.xyw = u_xlat16_4.xyw + (-u_xlat16_6.xyz);
    u_xlat16_4.xyw = vec3(u_xlat21) * u_xlat16_4.xyw + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyw;
    vs_TEXCOORD4 = u_xlat16_1;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat21) + 2.0;
    u_xlat16_4.x = u_xlat21 * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat21 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat21 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat23;
    u_xlat23 = u_xlat21 * _HeigtFogColDelta3.w;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=u_xlat3.x);
#else
    u_xlatb3 = u_xlat0.x>=u_xlat3.x;
#endif
    u_xlat21 = (u_xlatb3) ? u_xlat23 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor3.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColDelta3.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat23 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat14 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat23 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_4.x = (u_xlatb23) ? u_xlat10.x : 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat23 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_11.x = (-u_xlat23) + 2.0;
    u_xlat16_11.x = u_xlat23 * u_xlat16_11.x;
    u_xlat23 = u_xlat16_11.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat23 = min(u_xlat16_4.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat1.w = u_xlat21 * u_xlat10.x;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat16_4.x = (-u_xlat7.x) + 2.0;
    u_xlat16_4.x = u_xlat7.x * u_xlat16_4.x;
    u_xlat2.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat7.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb3) ? u_xlat21 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColDelta2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat21 = u_xlat14 * -1.44269502;
    u_xlat7.z = exp2(u_xlat21);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat7.z / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_4.x = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat14 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.x = (-u_xlat0.x) + 2.0;
    u_xlat16_11.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat0.x = u_xlat16_11.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColDelta2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat3.w = u_xlat14 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump float _ES_MoonSize;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	mediump float _ES_StarsBrightness;
uniform 	mediump float _ES_StarsDensity;
uniform 	vec4 _StarsColorPalette_ST;
uniform lowp sampler2D _StarsTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarsColorPalette;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
mediump vec2 u_xlat16_6;
float u_xlat12;
mediump float u_xlat16_12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = min(u_xlat12, 1.0);
    u_xlat12 = u_xlat12 + -0.5;
    u_xlat12 = u_xlat12 + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat5 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat0.x + -1.0;
    u_xlat16_6.x = abs(u_xlat5) * _ES_SunHaloSize;
    u_xlat0.x = u_xlat1.x * u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_6.xx * vec2(0.100000001, 0.00999999978);
    u_xlat4.xy = u_xlat1.xx * u_xlat16_6.xy;
    u_xlat0.yz = exp2(u_xlat4.xy);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.y * 0.119999997 + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * 0.0299999993 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _ES_SunHaloIntensity;
    u_xlat0.xyz = u_xlat0.xxx * _ES_SunHaloColor.xyz;
    u_xlat1.x = u_xlat12 * -2.0 + 3.0;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vs_TEXCOORD4.xyz;
    u_xlat16_6.x = _ES_MoonSize * 0.100000001;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-06);
    u_xlat16_6.x = float(1.0) / u_xlat16_6.x;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_6.x + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_6.x * u_xlat16_2;
    u_xlat16_6.x = _ES_MoonLunarPhase + -0.5;
    u_xlat16_6.x = -abs(u_xlat16_6.x) * 2.0 + 1.0;
    u_xlat16_12 = u_xlat16_6.x * _ES_MoonGlowIntensity;
    u_xlat12 = u_xlat16_12 * u_xlat16_2;
    u_xlat1.xyz = vec3(u_xlat12) * _ES_MoonColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0500000007>=u_xlat12);
#else
    u_xlatb12 = 0.0500000007>=u_xlat12;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat16_2 = _ES_MoonBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_2) + u_xlat0.xyz;
    u_xlat10_1 = texture(_NoiseTex, vs_TEXCOORD2.xy).w;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD2.zw).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat10_1;
    u_xlat10_5.x = texture(_StarsTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat10_5.x * u_xlat16_1;
    u_xlat5 = vs_TEXCOORD3.w * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_1 * u_xlat5;
    u_xlat1.x = u_xlat1.x * 3.0;
    u_xlat16_2 = (-_ES_StarsDensity) + 1.0;
    u_xlat10_5.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6.x = u_xlat10_5.x + (-_ES_StarsDensity);
    u_xlat3.x = u_xlat10_5.x * _StarsColorPalette_ST.x + _StarsColorPalette_ST.z;
    u_xlat16_2 = u_xlat16_6.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat16_2;
    u_xlat3.y = 0.5;
    u_xlat10_5.xyz = texture(_StarsColorPalette, u_xlat3.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * vec3(_ES_StarsBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat16_2 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat16_2) + vs_COLOR1.xyz;
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