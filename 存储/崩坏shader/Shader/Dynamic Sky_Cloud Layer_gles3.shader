//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Cloud Layer" {
Properties {
[Header(Cloud Maps)] _CloudDensityMap ("Cloud Density Map", 2D) = "white" { }
_CloudNormalMap ("Cloud Normal Map", 2D) = "bump" { }
_CloudWispsTex ("Cloud Wisps Tex", 2D) = "white" { }
[Header(Cloud Curl)] _CloudCurlTex ("Cloud Curl Tex", 2D) = "white" { }
_CloudCurlTiling ("Cloud Curl Tiling", Range(0, 30)) = 10
_CloudCurlAmplitude ("Cloud Curl Amplitude", Range(0, 0.02)) = 0.01
_CloudCurlSpeed ("Cloud Curl Speed", Range(0, 50)) = 20
[Header(Cloud Lighting)] _CloudDarkShadingNormalYScale ("Cloud Dark Shading Normal Y Scale", Range(0, 10)) = 3
_CloudLightShadingNormalYScale ("Cloud Light Shading Normal Y Scale", Range(0, 10)) = 3
[Header(Debug)] [Toggle(SHOW_WEATHERMAP)] _ShowWeatherMap ("Show Weather Map", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 64051
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat13;
vec2 u_xlat14;
mediump vec3 u_xlat16_17;
float u_xlat21;
vec2 u_xlat22;
mediump float u_xlat16_27;
float u_xlat30;
float u_xlat32;
mediump float u_xlat16_37;
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
    u_xlat30 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat30 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.ww;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat2.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat2.xy = vec2(_ES_CloudHeight) * u_xlat2.xy + in_TEXCOORD1.xy;
    u_xlat22.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat2.xy;
    u_xlat2.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat22.xy);
    u_xlat3 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat2.x = dot(u_xlat3.xy, u_xlat22.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat22.xy = u_xlat2.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat22.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat1;
    vs_TEXCOORD2.xy = u_xlat22.xy * vec2(0.699999988, 0.699999988) + u_xlat3.zw;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat1 = u_xlat0.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat30 = dot(u_xlat1.yzw, u_xlat1.yzw);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1 = vec4(u_xlat30) * u_xlat1;
    u_xlat30 = abs(u_xlat1.y) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat1.y) + 1.57072878;
    u_xlat22.x = -abs(u_xlat1.y) + 1.0;
    u_xlat22.x = sqrt(u_xlat22.x);
    u_xlat32 = u_xlat30 * u_xlat22.x;
    u_xlat32 = u_xlat32 * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb3 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat32 = u_xlatb3 ? u_xlat32 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat22.x + u_xlat32;
    u_xlat30 = u_xlat30 * 0.999899209;
    u_xlat3.x = sin(u_xlat30);
    u_xlat4 = cos(u_xlat30);
    u_xlat5 = u_xlat1 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat1 = u_xlat1.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat5);
    u_xlat5.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat5.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat13.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat22.x = dot(u_xlat13.xz, u_xlat1.yz);
    u_xlat6 = vec4(u_xlat1.z * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.w * u_xlat22.x, u_xlat1.y * u_xlat22.x);
    u_xlat6 = u_xlat5.zyyx * vec4(u_xlat30) + (-u_xlat6);
    u_xlat14.xy = vec2(u_xlat1.z * u_xlat6.z, u_xlat1.w * u_xlat6.w);
    u_xlat1.xw = u_xlat1.xy * u_xlat6.xy + (-u_xlat14.xy);
    u_xlat1.xw = u_xlat1.xw * u_xlat3.xx;
    u_xlat1.xw = vec2(u_xlat4) * u_xlat6.wx + u_xlat1.xw;
    u_xlat1.xy = u_xlat22.xx * u_xlat1.yz + u_xlat1.xw;
    vs_TEXCOORD2.zw = u_xlat5.xz * vec2(u_xlat30) + u_xlat1.xy;
    u_xlat30 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat1.xy = vec2(u_xlat30) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat2.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat1.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_7 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_17.x = u_xlat16_7 * u_xlat16_7;
    vs_TEXCOORD5.y = u_xlat16_17.x * u_xlat16_7 + -0.150000006;
    u_xlat16_7 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_7 = u_xlat16_7 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17.x;
    vs_TEXCOORD5.z = u_xlat16_7;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_17.x = dot(u_xlat0.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_17.x * 0.5 + 0.5;
    u_xlat16_17.x = u_xlat16_17.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_17.x = u_xlat16_17.x + 1.0;
    u_xlat16_27 = dot(_ES_SkyWorldUpDir.xyz, u_xlat0.xyz);
    u_xlat30 = abs(u_xlat16_27) * -0.0187292993 + 0.0742610022;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + -0.212114394;
    u_xlat30 = u_xlat30 * abs(u_xlat16_27) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_27) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat16_27<(-u_xlat16_27));
#else
    u_xlatb11 = u_xlat16_27<(-u_xlat16_27);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat21 = u_xlat30 * u_xlat1.x;
    u_xlat21 = u_xlat21 * -2.0 + 3.14159274;
    u_xlat11 = u_xlatb11 ? u_xlat21 : float(0.0);
    u_xlat30 = u_xlat30 * u_xlat1.x + u_xlat11;
    u_xlat30 = (-u_xlat30) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat30 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat13.zxy;
    u_xlat2.xyz = u_xlat13.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16_8.z = dot(u_xlat13.xyz, _ES_LightDirection.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat1.xyz = u_xlat2.xyz * in_TANGENT0.www;
    u_xlat16_8.y = dot(u_xlat1.xyz, _ES_LightDirection.xyz);
    u_xlat16_27 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz;
    u_xlat30 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat0.xyz);
    u_xlat30 = u_xlat30 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_27 = log2(u_xlat30);
    u_xlat30 = dot(u_xlat0.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat0.x = dot(_ES_MoonDirection.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_37 = abs(u_xlat30) * _ES_SunHaloSize;
    u_xlat16_37 = u_xlat16_37 * 0.5;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = u_xlat30 * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 * _ES_SunHaloIntensity;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * _ES_SunColor.xyz;
    u_xlat16_27 = u_xlat0.x * u_xlat0.x;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat0.x * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat0.x + -0.5;
    u_xlat16_17.y = u_xlat16_27 + u_xlat16_27;
    u_xlat16_17.xy = max(u_xlat16_17.xy, vec2(0.0, 0.0));
    u_xlat16_37 = u_xlat16_17.y * -2.0 + 3.0;
    u_xlat16_27 = u_xlat16_17.y * u_xlat16_17.y;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_37;
    u_xlat16_27 = u_xlat16_27 * _ES_MoonGlowIntensity;
    u_xlat16_37 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_37 = -abs(u_xlat16_37) * 2.0 + 1.0;
    u_xlat16_27 = u_xlat16_37 * u_xlat16_27;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * _ES_MoonColor.xyz;
    u_xlat16_27 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 0.800000012);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat16_27) + u_xlat16_8.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_7) * u_xlat16_8.xyz;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_17.x;
    u_xlat16_7 = u_xlat16_17.x * u_xlat16_7;
    u_xlat16_17.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_17.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_7) * u_xlat16_17.xyz + _ES_CloudDarkBackColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    SV_Target0.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
vec2 u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13 = u_xlat33 * u_xlat34;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13 : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat22.x = u_xlat22.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22.x = min(max(u_xlat22.x, 0.0), 1.0);
#else
    u_xlat22.x = clamp(u_xlat22.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat22.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat0.x>=u_xlat22.x);
#else
    u_xlatb22 = u_xlat0.x>=u_xlat22.x;
#endif
    u_xlat33 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta.w;
    u_xlat22.x = (u_xlatb22) ? u_xlat34 : u_xlat33;
    u_xlat22.x = log2(u_xlat22.x);
    u_xlat22.x = u_xlat22.x * _Mihoyo_FogColor.w;
    u_xlat22.x = exp2(u_xlat22.x);
    u_xlat22.x = min(u_xlat22.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat22.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat11 * -1.44269502;
    u_xlat22.y = exp2(u_xlat33);
    u_xlat22.xy = (-u_xlat22.xy) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat22.y / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_8 = (u_xlatb11) ? u_xlat33 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat11 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta.w);
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat2.w = u_xlat11 * u_xlat22.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump vec3 _ES_LightDirection;
uniform 	mediump vec3 _ES_SunDirection;
uniform 	mediump vec3 _ES_SunColor;
uniform 	mediump float _ES_SunHaloSize;
uniform 	mediump float _ES_SunHaloIntensity;
uniform 	mediump vec3 _ES_MoonDirection;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform 	mediump float _ES_MoonGlowIntensity;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	float _ES_CloudElapsedTime;
uniform 	vec2 _ES_CloudDirection;
uniform 	mediump vec3 _ES_CloudLightFrontColor;
uniform 	mediump vec3 _ES_CloudLightBackColor;
uniform 	mediump vec3 _ES_CloudDarkFrontColor;
uniform 	mediump vec3 _ES_CloudDarkBackColor;
uniform 	mediump float _ES_CloudFrontAndBackBlendFactor;
uniform 	mediump float _ES_CloudHeight;
uniform 	float _ES_CloudTiling;
uniform 	mediump float _ES_CloudCoverage;
uniform 	float _ES_CloudWispsElapsedTime;
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
uniform 	float _CloudCurlTiling;
uniform 	float _CloudCurlSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
out mediump vec3 vs_TEXCOORD8;
out mediump vec3 vs_TEXCOORD9;
out mediump vec3 vs_TEXCOORD10;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec4 u_xlat6;
vec4 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat13;
vec3 u_xlat15;
mediump vec3 u_xlat16_19;
float u_xlat22;
bool u_xlatb22;
vec2 u_xlat25;
mediump float u_xlat16_30;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
bool u_xlatb36;
mediump float u_xlat16_41;
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
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat2.ww;
    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat2 = vec4(_ES_CloudElapsedTime) * vec4(0.600000024, 0.0, 0.780000031, 0.0);
    u_xlat3.xy = (-in_TEXCOORD1.xy) + in_TEXCOORD2.xy;
    u_xlat3.xy = vec2(_ES_CloudHeight) * u_xlat3.xy + in_TEXCOORD1.xy;
    u_xlat25.xy = u_xlat3.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD4.xy = u_xlat3.xy;
    u_xlat3.y = dot(vec2(_ES_CloudDirection.x, _ES_CloudDirection.y), u_xlat25.xy);
    u_xlat4 = vec4(_ES_CloudDirection.y, _ES_CloudDirection.x, _ES_CloudElapsedTime, _ES_CloudElapsedTime) * vec4(1.0, -1.0, 0.280000001, 0.00349999988);
    u_xlat3.x = dot(u_xlat4.xy, u_xlat25.xy);
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat25.xy = u_xlat3.xy * vec2(_ES_CloudTiling);
    vs_TEXCOORD1 = u_xlat25.xyxy * vec4(1.20000005, 1.20000005, 0.899999976, 0.899999976) + u_xlat2;
    vs_TEXCOORD2.xy = u_xlat25.xy * vec2(0.699999988, 0.699999988) + u_xlat4.zw;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2 = u_xlat1.zyxz * vec4(1.0, -1.0, 1.0, 1.0);
    u_xlat33 = dot(u_xlat2.yzw, u_xlat2.yzw);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2 = vec4(u_xlat33) * u_xlat2;
    u_xlat33 = abs(u_xlat2.y) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat2.y) + 1.57072878;
    u_xlat34 = -abs(u_xlat2.y) + 1.0;
    u_xlat34 = sqrt(u_xlat34);
    u_xlat25.x = u_xlat33 * u_xlat34;
    u_xlat25.x = u_xlat25.x * -2.0 + 3.14159274;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat2.y<(-u_xlat2.y));
#else
    u_xlatb36 = u_xlat2.y<(-u_xlat2.y);
#endif
    u_xlat25.x = u_xlatb36 ? u_xlat25.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat25.x;
    u_xlat33 = u_xlat33 * 0.999899209;
    u_xlat4.x = sin(u_xlat33);
    u_xlat5 = cos(u_xlat33);
    u_xlat6 = u_xlat2 * vec4(0.0, 0.0, 1.0, 0.0);
    u_xlat2 = u_xlat2.zwyz * vec4(0.0, 1.0, 0.0, 0.0) + (-u_xlat6);
    u_xlat6.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat6.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat6.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat15.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat34 = dot(u_xlat15.xz, u_xlat2.yz);
    u_xlat7 = vec4(u_xlat2.z * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.w * float(u_xlat34), u_xlat2.y * float(u_xlat34));
    u_xlat7 = u_xlat6.zyyx * vec4(u_xlat33) + (-u_xlat7);
    u_xlat25.xy = vec2(u_xlat2.z * u_xlat7.z, u_xlat2.w * u_xlat7.w);
    u_xlat2.xw = u_xlat2.xy * u_xlat7.xy + (-u_xlat25.xy);
    u_xlat2.xw = u_xlat2.xw * u_xlat4.xx;
    u_xlat2.xw = vec2(u_xlat5) * u_xlat7.wx + u_xlat2.xw;
    u_xlat2.xy = vec2(u_xlat34) * u_xlat2.yz + u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat6.xz * vec2(u_xlat33) + u_xlat2.xy;
    u_xlat33 = _ES_CloudElapsedTime * _CloudCurlSpeed;
    u_xlat2.xy = vec2(u_xlat33) * vec2(1.20000005, 0.800000012);
    vs_TEXCOORD3.xy = u_xlat3.xy * vec2(vec2(_CloudCurlTiling, _CloudCurlTiling)) + u_xlat2.xy;
    vs_TEXCOORD3.z = in_TEXCOORD0.x + _ES_CloudWispsElapsedTime;
    vs_TEXCOORD3.w = in_TEXCOORD0.y;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat16_8 = (-_ES_CloudCoverage) * 0.699999988 + 1.0;
    u_xlat16_19.x = u_xlat16_8 * u_xlat16_8;
    vs_TEXCOORD5.y = u_xlat16_19.x * u_xlat16_8 + -0.150000006;
    u_xlat16_8 = (-_ES_CloudCoverage) + 0.699999988;
    u_xlat16_8 = u_xlat16_8 * 2.50000024;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_19.x = u_xlat16_8 * -2.0 + 3.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_19.x;
    vs_TEXCOORD5.z = u_xlat16_8;
    vs_TEXCOORD5.x = _ES_CloudCoverage;
    u_xlat16_19.x = dot(u_xlat1.xyz, vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z));
    vs_TEXCOORD5.w = u_xlat16_19.x * 0.5 + 0.5;
    u_xlat16_19.x = u_xlat16_19.x * _ES_CloudFrontAndBackBlendFactor + (-_ES_CloudFrontAndBackBlendFactor);
    u_xlat16_19.x = u_xlat16_19.x + 1.0;
    u_xlat16_30 = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    u_xlat33 = abs(u_xlat16_30) * -0.0187292993 + 0.0742610022;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + -0.212114394;
    u_xlat33 = u_xlat33 * abs(u_xlat16_30) + 1.57072878;
    u_xlat34 = -abs(u_xlat16_30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_30<(-u_xlat16_30));
#else
    u_xlatb2 = u_xlat16_30<(-u_xlat16_30);
#endif
    u_xlat34 = sqrt(u_xlat34);
    u_xlat13.x = u_xlat33 * u_xlat34;
    u_xlat13.x = u_xlat13.x * -2.0 + 3.14159274;
    u_xlat2.x = u_xlatb2 ? u_xlat13.x : float(0.0);
    u_xlat33 = u_xlat33 * u_xlat34 + u_xlat2.x;
    u_xlat33 = (-u_xlat33) + 1.57079637;
    vs_TEXCOORD6.w = u_xlat33 * 0.636619806;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat15.zxy;
    u_xlat3.xyz = u_xlat15.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat16_9.z = dot(u_xlat15.xyz, _ES_LightDirection.xyz);
    u_xlat16_9.x = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat2.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat16_9.y = dot(u_xlat2.xyz, _ES_LightDirection.xyz);
    u_xlat16_30 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    vs_TEXCOORD7.xyz = vec3(u_xlat16_30) * u_xlat16_9.xyz;
    u_xlat33 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat1.xyz);
    u_xlat33 = u_xlat33 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat33);
    u_xlat33 = dot(u_xlat1.xyz, _ES_SkyWorldUpDir.xyz);
    u_xlat1.x = dot(_ES_MoonDirection.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = abs(u_xlat33) * _ES_SunHaloSize;
    u_xlat16_41 = u_xlat16_41 * 0.5;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_30 = u_xlat33 * u_xlat16_30;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = u_xlat16_30 * _ES_SunHaloIntensity;
    u_xlat16_9.xyz = vec3(u_xlat16_30) * _ES_SunColor.xyz;
    u_xlat16_30 = u_xlat1.x * u_xlat1.x;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat1.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat1.x + -0.5;
    u_xlat16_19.y = u_xlat16_30 + u_xlat16_30;
    u_xlat16_19.xy = max(u_xlat16_19.xy, vec2(0.0, 0.0));
    u_xlat16_41 = u_xlat16_19.y * -2.0 + 3.0;
    u_xlat16_30 = u_xlat16_19.y * u_xlat16_19.y;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_41;
    u_xlat16_30 = u_xlat16_30 * _ES_MoonGlowIntensity;
    u_xlat16_41 = _ES_MoonLunarPhase + -0.5;
    u_xlat16_41 = -abs(u_xlat16_41) * 2.0 + 1.0;
    u_xlat16_30 = u_xlat16_41 * u_xlat16_30;
    u_xlat16_10.xyz = vec3(u_xlat16_30) * _ES_MoonColor.xyz;
    u_xlat16_30 = max(_ES_MoonBrightness, 0.0);
    u_xlat16_30 = min(u_xlat16_30, 0.800000012);
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    vs_TEXCOORD8.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
    u_xlat16_19.xyz = _ES_CloudLightFrontColor.xyz + (-_ES_CloudLightBackColor.xyz);
    vs_TEXCOORD9.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudLightBackColor.xyz;
    u_xlat16_19.xyz = _ES_CloudDarkFrontColor.xyz + (-_ES_CloudDarkBackColor.xyz);
    vs_TEXCOORD10.xyz = vec3(u_xlat16_8) * u_xlat16_19.xyz + _ES_CloudDarkBackColor.xyz;
    u_xlat33 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat33) + 2.0;
    u_xlat16_8 = u_xlat33 * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat33 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat33 = u_xlat33 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat33 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat34 = (-u_xlat33) + 2.0;
    u_xlat33 = u_xlat33 * u_xlat34;
    u_xlat34 = u_xlat33 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat33 = (u_xlatb2) ? u_xlat34 : u_xlat33;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _Mihoyo_FogColor3.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = (-u_xlat33) + 1.0;
    u_xlat34 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat22 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13.x = u_xlat34 * -1.44269502;
    u_xlat13.x = exp2(u_xlat13.x);
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat13.x = u_xlat13.x / u_xlat34;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat16_8 = (u_xlatb34) ? u_xlat13.x : 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat34 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_19.x = (-u_xlat34) + 2.0;
    u_xlat16_19.x = u_xlat34 * u_xlat16_19.x;
    u_xlat34 = u_xlat16_19.x * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat34 = u_xlat34 + 1.0;
    u_xlat16_8 = u_xlat34 * u_xlat16_8;
    u_xlat34 = min(u_xlat16_8, _HeigtFogColDelta3.w);
    u_xlat13.x = (-u_xlat34) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
    u_xlat3.w = u_xlat33 * u_xlat13.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat34) + u_xlat1.xyz;
    u_xlat16_8 = (-u_xlat11.x) + 2.0;
    u_xlat16_8 = u_xlat11.x * u_xlat16_8;
    u_xlat1.xyz = vec3(u_xlat16_8) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat13.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat11.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat11.x = u_xlat11.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat11.xxx * u_xlat13.xyz + u_xlat1.xyz;
    u_xlat11.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat33 = (-u_xlat11.x) + 2.0;
    u_xlat11.x = u_xlat33 * u_xlat11.x;
    u_xlat33 = u_xlat11.x * _HeigtFogColDelta2.w;
    u_xlat11.x = (u_xlatb2) ? u_xlat33 : u_xlat11.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * _Mihoyo_FogColor2.w;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = min(u_xlat11.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat33 = u_xlat22 * -1.44269502;
    u_xlat11.z = exp2(u_xlat33);
    u_xlat11.xz = (-u_xlat11.xz) + vec2(1.0, 1.0);
    u_xlat33 = u_xlat11.z / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_8 = (u_xlatb22) ? u_xlat33 : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat22 * u_xlat16_8;
    u_xlat16_8 = exp2((-u_xlat16_8));
    u_xlat16_8 = min(u_xlat16_8, 1.0);
    u_xlat16_8 = (-u_xlat16_8) + 1.0;
    u_xlat16_19.x = (-u_xlat0.x) + 2.0;
    u_xlat16_19.x = u_xlat0.x * u_xlat16_19.x;
    u_xlat0.x = u_xlat16_19.x * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = min(u_xlat16_8, _HeigtFogColDelta2.w);
    u_xlat22 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.w = u_xlat22 * u_xlat11.x;
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
uniform 	mediump float _ES_SunBrightness;
uniform 	mediump float _ES_SunRimLightRadius;
uniform 	mediump vec3 _ES_SunHaloColor;
uniform 	mediump float _ES_CloudCoverage;
uniform 	mediump float _ES_CloudOpacity;
uniform 	mediump vec2 _ES_CloudSmoothness;
uniform 	mediump float _ES_CloudSunBrightenIntensity;
uniform 	mediump float _ES_CloudWispsCoverage;
uniform 	mediump float _ES_CloudWispsOpacity;
uniform 	float _CloudCurlAmplitude;
uniform 	mediump float _CloudDarkShadingNormalYScale;
uniform lowp sampler2D _ES_WeatherMap;
uniform lowp sampler2D _CloudCurlTex;
uniform lowp sampler2D _CloudDensityMap;
uniform lowp sampler2D _CloudNormalMap;
uniform lowp sampler2D _CloudWispsTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
in mediump vec3 vs_TEXCOORD8;
in mediump vec3 vs_TEXCOORD9;
in mediump vec3 vs_TEXCOORD10;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat14;
mediump float u_xlat16_17;
mediump float u_xlat16_19;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat10_0.xy = texture(_CloudCurlTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat10_1.xyz = texture(_ES_WeatherMap, vs_TEXCOORD4.xy).xyz;
    u_xlat14 = u_xlat10_1.y * _CloudCurlAmplitude;
    u_xlat14 = u_xlat14 * 0.800000012;
    u_xlat14 = _CloudCurlAmplitude * 0.200000003 + u_xlat14;
    u_xlat8.xz = u_xlat16_0.xy * vec2(u_xlat14) + vs_TEXCOORD2.xy;
    u_xlat10_2.xyz = texture(_CloudNormalMap, u_xlat8.xz).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.y = u_xlat16_3.y * _CloudDarkShadingNormalYScale;
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vs_TEXCOORD7.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_10) * u_xlat16_3.x + 1.0;
    u_xlat8.xz = vec2(u_xlat14) * u_xlat16_0.xy;
    u_xlat0 = u_xlat16_0.xyxy * vec4(u_xlat14) + vs_TEXCOORD1;
    u_xlat10_2.xyz = texture(_CloudDensityMap, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_CloudDensityMap, u_xlat0.zw).xyz;
    u_xlat16_10 = (-u_xlat10_2.y) * 0.00999999978 + 0.0299999993;
    u_xlat9.xz = vs_TEXCOORD2.zw * vec2(u_xlat16_10) + vs_TEXCOORD2.xy;
    u_xlat8.xz = u_xlat8.xz * vec2(0.5, 0.5) + u_xlat9.xz;
    u_xlat10_4.xyz = texture(_CloudDensityMap, u_xlat8.xz).xyz;
    u_xlat16_10 = dot(u_xlat10_4.yy, u_xlat10_4.zz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat10_4.x + -0.5;
    u_xlat16_10 = u_xlat16_17 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17;
    u_xlat16_5.xyz = vs_TEXCOORD9.xyz + (-vs_TEXCOORD10.xyz);
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_5.xyz + vs_TEXCOORD10.xyz;
    u_xlat16_5.x = u_xlat10_2.x + -0.5;
    u_xlat16_5.x = u_xlat16_5.x * 0.150000006;
    u_xlat16_5.x = u_xlat10_0.z * u_xlat10_2.z + u_xlat16_5.x;
    u_xlat16_0.x = dot(u_xlat10_0.xx, u_xlat10_0.yy);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat10_1.x * u_xlat16_5.x;
    u_xlat16_19 = vs_TEXCOORD6.w * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_19 * -2.0 + 3.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_26;
    u_xlat16_19 = min(u_xlat16_19, 1.0);
    u_xlat16_26 = (-u_xlat16_19) + 1.0;
    u_xlat16_5.x = u_xlat16_26 * 0.200000003 + u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_5.x + (-vs_TEXCOORD5.y);
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat16_7.x = u_xlat16_0.x / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_7.x) + 0.5;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_26 = (-_ES_SunRimLightRadius) + 1.0;
    u_xlat16_26 = float(1.0) / u_xlat16_26;
    u_xlat16_6.x = vs_TEXCOORD5.w + (-_ES_SunRimLightRadius);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_26 = u_xlat16_26 * _ES_SunBrightness;
    u_xlat16_6.xy = vec2(u_xlat16_26) * vec2(0.0500000007, 1.5);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_6.y;
    u_xlat16_26 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = u_xlat16_26 * u_xlat16_5.x;
    u_xlat16_6.xyz = u_xlat16_5.xxx * _ES_SunHaloColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_12) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vs_TEXCOORD5.zzz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vec3(50.0, 50.0, 50.0) + u_xlat16_3.xzw;
    u_xlat16_5.x = u_xlat16_12 * 0.5;
    u_xlat16_6.xyz = u_xlat16_5.xxx * vs_TEXCOORD9.xyz;
    u_xlat16_3.xzw = u_xlat16_6.xyz * vs_TEXCOORD5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.xyz = vs_TEXCOORD8.xyz * vec3(u_xlat16_10) + u_xlat16_3.xzw;
    u_xlat10_7 = texture(_CloudWispsTex, vs_TEXCOORD3.zw).w;
    u_xlat16_24 = (-_ES_CloudWispsCoverage) + 1.0;
    u_xlat16_5.x = u_xlat10_7 + (-u_xlat16_24);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = u_xlat16_5.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_24 * _ES_CloudWispsOpacity;
    u_xlat16_7.xyz = (-vs_TEXCOORD9.xyz) + vs_TEXCOORD10.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz + vs_TEXCOORD9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_7.xyz;
    u_xlat16_24 = (-_ES_CloudSmoothness.xxyx.y) + _ES_CloudSmoothness.xxyx.z;
    u_xlat16_24 = u_xlat10_1.z * u_xlat16_24 + _ES_CloudSmoothness.xxyx.y;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + 0.0500000007;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_24 = u_xlat16_19 * u_xlat16_0.x;
    u_xlat16_5.x = u_xlat16_24 * _ES_CloudOpacity;
    u_xlat16_24 = (-u_xlat16_24) * _ES_CloudOpacity + 1.0;
    u_xlat16_12 = _ES_CloudCoverage + -0.5;
    u_xlat16_12 = u_xlat16_12 * 5.00000048;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_19 = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_19;
    u_xlat16_24 = u_xlat16_12 * u_xlat16_24 + u_xlat16_5.x;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat16_24;
    u_xlat16_24 = vs_TEXCOORD5.w * _ES_CloudSunBrightenIntensity + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_24 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24) + vs_COLOR1.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
}
}
}
}