//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Background/Full Screen Transparent" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
_ChromaTex ("Chroma", 2D) = "gray" { }
_Color ("Main Color", Color) = (1,1,1,1)
[KeywordEnum(None, Top_Bottom, Left_Right)] AlphaPack ("Alpha Pack", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Background+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Background+1" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17003
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
bool u_xlatb4;
bool u_xlatb5;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat1.y = _MainTex_TexelSize.w / _MainTex_TexelSize.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat1.x<u_xlat1.y);
#else
    u_xlatb5 = u_xlat1.x<u_xlat1.y;
#endif
    u_xlat0.xw = u_xlat1.xy / u_xlat1.yx;
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat2 = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
bool u_xlatb3;
float u_xlat6;
bool u_xlatb6;
bool u_xlatb10;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = vec2(_MainTex_TexelSize.w * float(0.5), _MainTex_TexelSize.y * float(1.5));
    u_xlat1.x = u_xlat1.x / _MainTex_TexelSize.z;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb10 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb10)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb6 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb6) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
    u_xlat0.x = _MainTex_TexelSize.y * -3.0 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb3 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb3) ? u_xlat6 : u_xlat2.y;
    u_xlat1.x = u_xlat6 * u_xlat0.x + u_xlat1.y;
    u_xlat1.yz = u_xlat1.xx + vec2(0.5, 0.5);
    u_xlat0.xz = (-u_xlat1.yx) + vec2(1.0, 1.0);
    u_xlat2.zw = (bool(u_xlatb3)) ? u_xlat0.xz : u_xlat1.zx;
    vs_TEXCOORD0 = u_xlat2.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * _Color.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec2 u_xlat2;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb7;
void main()
{
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat1.xy = _MainTex_TexelSize.zx * vec2(0.5, 1.5);
    u_xlat1.x = _MainTex_TexelSize.w / u_xlat1.x;
    u_xlat1.z = _ScreenParams.y / _ScreenParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.z<u_xlat1.x);
#else
    u_xlatb7 = u_xlat1.z<u_xlat1.x;
#endif
    u_xlat0.xw = u_xlat1.zx / u_xlat1.xz;
    u_xlat0.xy = (bool(u_xlatb7)) ? u_xlat0.xy : u_xlat0.zw;
    u_xlat0.xy = u_xlat0.xy * in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_ProjectionParams.x<0.0);
#else
    u_xlatb4 = _ProjectionParams.x<0.0;
#endif
    gl_Position.y = (u_xlatb4) ? (-u_xlat0.y) : u_xlat0.y;
    gl_Position.x = u_xlat0.x;
    gl_Position.zw = vec2(-1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MainTex_ST.y<0.0);
#else
    u_xlatb0 = _MainTex_ST.y<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    u_xlat6 = (u_xlatb0) ? u_xlat6 : u_xlat2.y;
    u_xlat6 = (-u_xlat6) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat0.x + u_xlat1.y;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * _Color;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
}
}
}
}