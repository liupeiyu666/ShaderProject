//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/ScreenFilter_Multiply" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(REVERSEU)] _ReverseU ("Reverse U Coord", Float) = 0
[Toggle(REVERSEV)] _ReverseV ("Reverse V Coord", Float) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51005
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = vs_COLOR0.w * u_xlat10_0.w + -1.0;
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 117274
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
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
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
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
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
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
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
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
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
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
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
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
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}