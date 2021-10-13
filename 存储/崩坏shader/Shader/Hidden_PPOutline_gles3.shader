//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PPOutline" {
Properties {
_MainTex ("Texture", 2D) = "" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 43292
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _BloomFactor;
uniform 	vec4 _LineColor;
uniform 	float _LineWidth;
uniform 	float _DepthThreshold;
uniform 	float _NearStart;
uniform 	float _NearEnd;
uniform 	float _FarStart;
uniform 	float _FarEnd;
uniform 	float _LineMaxDist;
uniform 	float _ColorMultiplier;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = (-_FarStart) + _FarEnd;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3.x = _LineWidth * 0.5;
    u_xlat6.x = ceil(u_xlat3.x);
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat1.xy = u_xlat6.xx * _MainTex_TexelSize.xy;
    u_xlat1.zw = u_xlat3.xx * (-_MainTex_TexelSize.yx);
    u_xlat3.xy = (-_MainTex_TexelSize.xy) * u_xlat3.xx + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat6.xy = vec2(u_xlat1.w + vs_TEXCOORD0.x, u_xlat1.y + vs_TEXCOORD0.y);
    u_xlat1 = u_xlat1.xyxz + vs_TEXCOORD0.xyxy;
    u_xlat10_6 = texture(_CustomDepthTexture, u_xlat6.xy).x;
    u_xlat10_9 = texture(_CustomDepthTexture, u_xlat1.zw).x;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat16_4 = max(u_xlat10_6, u_xlat10_9);
    u_xlat16_6 = (-u_xlat10_9) + u_xlat10_6;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_9 = max(u_xlat10_3, u_xlat10_1.x);
    u_xlat16_1 = (-u_xlat10_3) + u_xlat10_1.x;
    u_xlat3.x = u_xlat10_3 * _DepthThreshold;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + u_xlat16_6;
    u_xlat16_6 = sqrt(u_xlat16_6);
    u_xlat6.x = u_xlat16_6 * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<u_xlat6.x);
#else
    u_xlatb3 = u_xlat3.x<u_xlat6.x;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat16_6 = max(u_xlat16_4, u_xlat16_9);
    u_xlat6.x = _ZBufferParams.x * u_xlat16_6 + _ZBufferParams.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat1.xy = u_xlat6.xx + (-vec2(_FarStart, _LineMaxDist));
    u_xlat6.x = u_xlat6.x + (-_NearStart);
    u_xlat0 = u_xlat0 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat1.y * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat1.x = (-_NearStart) + _NearEnd;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x * -2.0 + 3.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat0 = u_xlat1.x * u_xlat6.x + (-u_xlat0);
    u_xlat0 = u_xlat9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat3.x = u_xlat0 * _ColorMultiplier + 1.0;
    u_xlat6.x = u_xlat0 * _LineColor.w;
    u_xlat9 = (-_LineColor.w) * u_xlat0 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat10_1.xyz;
    u_xlat1.xyz = _LineColor.xyz * u_xlat6.xxx + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat3.x = (-u_xlat10_1.w) + _BloomFactor;
    u_xlat2.w = u_xlat0 * u_xlat3.x + u_xlat10_1.w;
    SV_Target0 = u_xlat2;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _BloomFactor;
uniform 	vec4 _LineColor;
uniform 	float _LineWidth;
uniform 	float _DepthThreshold;
uniform 	float _NearStart;
uniform 	float _NearEnd;
uniform 	float _FarStart;
uniform 	float _FarEnd;
uniform 	float _LineMaxDist;
uniform 	float _ColorMultiplier;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = (-_FarStart) + _FarEnd;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3.x = _LineWidth * 0.5;
    u_xlat6.x = ceil(u_xlat3.x);
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat1.xy = u_xlat6.xx * _MainTex_TexelSize.xy;
    u_xlat1.zw = u_xlat3.xx * (-_MainTex_TexelSize.yx);
    u_xlat3.xy = (-_MainTex_TexelSize.xy) * u_xlat3.xx + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat6.xy = vec2(u_xlat1.w + vs_TEXCOORD0.x, u_xlat1.y + vs_TEXCOORD0.y);
    u_xlat1 = u_xlat1.xyxz + vs_TEXCOORD0.xyxy;
    u_xlat10_6 = texture(_CustomDepthTexture, u_xlat6.xy).x;
    u_xlat10_9 = texture(_CustomDepthTexture, u_xlat1.zw).x;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat16_4 = max(u_xlat10_6, u_xlat10_9);
    u_xlat16_6 = (-u_xlat10_9) + u_xlat10_6;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_9 = max(u_xlat10_3, u_xlat10_1.x);
    u_xlat16_1 = (-u_xlat10_3) + u_xlat10_1.x;
    u_xlat3.x = u_xlat10_3 * _DepthThreshold;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + u_xlat16_6;
    u_xlat16_6 = sqrt(u_xlat16_6);
    u_xlat6.x = u_xlat16_6 * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<u_xlat6.x);
#else
    u_xlatb3 = u_xlat3.x<u_xlat6.x;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat16_6 = max(u_xlat16_4, u_xlat16_9);
    u_xlat6.x = _ZBufferParams.x * u_xlat16_6 + _ZBufferParams.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat1.xy = u_xlat6.xx + (-vec2(_FarStart, _LineMaxDist));
    u_xlat6.x = u_xlat6.x + (-_NearStart);
    u_xlat0 = u_xlat0 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat1.y * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat1.x = (-_NearStart) + _NearEnd;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x * -2.0 + 3.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat0 = u_xlat1.x * u_xlat6.x + (-u_xlat0);
    u_xlat0 = u_xlat9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat3.x = u_xlat0 * _ColorMultiplier + 1.0;
    u_xlat6.x = u_xlat0 * _LineColor.w;
    u_xlat9 = (-_LineColor.w) * u_xlat0 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat10_1.xyz;
    u_xlat1.xyz = _LineColor.xyz * u_xlat6.xxx + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat3.x = (-u_xlat10_1.w) + _BloomFactor;
    u_xlat2.w = u_xlat0 * u_xlat3.x + u_xlat10_1.w;
    SV_Target0 = u_xlat2;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _BloomFactor;
uniform 	vec4 _LineColor;
uniform 	float _LineWidth;
uniform 	float _DepthThreshold;
uniform 	float _NearStart;
uniform 	float _NearEnd;
uniform 	float _FarStart;
uniform 	float _FarEnd;
uniform 	float _LineMaxDist;
uniform 	float _ColorMultiplier;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = (-_FarStart) + _FarEnd;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3.x = _LineWidth * 0.5;
    u_xlat6.x = ceil(u_xlat3.x);
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat1.xy = u_xlat6.xx * _MainTex_TexelSize.xy;
    u_xlat1.zw = u_xlat3.xx * (-_MainTex_TexelSize.yx);
    u_xlat3.xy = (-_MainTex_TexelSize.xy) * u_xlat3.xx + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture(_CustomDepthTexture, u_xlat3.xy).x;
    u_xlat6.xy = vec2(u_xlat1.w + vs_TEXCOORD0.x, u_xlat1.y + vs_TEXCOORD0.y);
    u_xlat1 = u_xlat1.xyxz + vs_TEXCOORD0.xyxy;
    u_xlat10_6 = texture(_CustomDepthTexture, u_xlat6.xy).x;
    u_xlat10_9 = texture(_CustomDepthTexture, u_xlat1.zw).x;
    u_xlat10_1.x = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat16_4 = max(u_xlat10_6, u_xlat10_9);
    u_xlat16_6 = (-u_xlat10_9) + u_xlat10_6;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_9 = max(u_xlat10_3, u_xlat10_1.x);
    u_xlat16_1 = (-u_xlat10_3) + u_xlat10_1.x;
    u_xlat3.x = u_xlat10_3 * _DepthThreshold;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + u_xlat16_6;
    u_xlat16_6 = sqrt(u_xlat16_6);
    u_xlat6.x = u_xlat16_6 * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<u_xlat6.x);
#else
    u_xlatb3 = u_xlat3.x<u_xlat6.x;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat16_6 = max(u_xlat16_4, u_xlat16_9);
    u_xlat6.x = _ZBufferParams.x * u_xlat16_6 + _ZBufferParams.y;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-_ProjectionParams.y);
    u_xlat1.xy = u_xlat6.xx + (-vec2(_FarStart, _LineMaxDist));
    u_xlat6.x = u_xlat6.x + (-_NearStart);
    u_xlat0 = u_xlat0 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat1.y * 100.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat1.x = (-_NearStart) + _NearEnd;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x * -2.0 + 3.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat0 = u_xlat1.x * u_xlat6.x + (-u_xlat0);
    u_xlat0 = u_xlat9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat3.x = u_xlat0 * _ColorMultiplier + 1.0;
    u_xlat6.x = u_xlat0 * _LineColor.w;
    u_xlat9 = (-_LineColor.w) * u_xlat0 + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat10_1.xyz;
    u_xlat1.xyz = _LineColor.xyz * u_xlat6.xxx + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat3.x = (-u_xlat10_1.w) + _BloomFactor;
    u_xlat2.w = u_xlat0 * u_xlat3.x + u_xlat10_1.w;
    SV_Target0 = u_xlat2;
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