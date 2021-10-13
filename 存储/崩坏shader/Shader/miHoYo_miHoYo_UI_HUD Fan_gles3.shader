//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/HUD Fan" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_Texture ("Texture", 2D) = "white" { }
_FanAngle ("Fan Angle", Range(0.1, 6.28318)) = 1.57
_BorderAngle ("Border Triangle Angle", Range(0, 0.3)) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 8392
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
int u_xlati4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb6 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb2 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat2 = (-_BorderAngle) + 3.14159012;
    u_xlat4 = (-u_xlat2) + u_xlat0.x;
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat4 = floor(u_xlat4);
    u_xlat4 = max(u_xlat4, 0.0);
    u_xlati4 = int(u_xlat4);
    u_xlat6 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = (-u_xlat2) + u_xlat0.x;
    u_xlat2 = u_xlat1.x / u_xlat2;
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : u_xlat2;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat2 = u_xlat2 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat2) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
int u_xlati4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb6 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb2 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat2 = (-_BorderAngle) + 3.14159012;
    u_xlat4 = (-u_xlat2) + u_xlat0.x;
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat4 = floor(u_xlat4);
    u_xlat4 = max(u_xlat4, 0.0);
    u_xlati4 = int(u_xlat4);
    u_xlat6 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = (-u_xlat2) + u_xlat0.x;
    u_xlat2 = u_xlat1.x / u_xlat2;
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : u_xlat2;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat2 = u_xlat2 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat2) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
int u_xlati4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb6 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb2 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat2 = (-_BorderAngle) + 3.14159012;
    u_xlat4 = (-u_xlat2) + u_xlat0.x;
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat4 = floor(u_xlat4);
    u_xlat4 = max(u_xlat4, 0.0);
    u_xlati4 = int(u_xlat4);
    u_xlat6 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = (-u_xlat2) + u_xlat0.x;
    u_xlat2 = u_xlat1.x / u_xlat2;
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : u_xlat2;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat2 = u_xlat2 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat2) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    vs_TEXCOORD1 = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler);
    SV_Target0.w = u_xlat16_0.w;
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
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 113508
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _Texture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Texture, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}