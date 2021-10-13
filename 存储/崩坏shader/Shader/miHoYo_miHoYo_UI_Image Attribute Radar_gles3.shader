//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Attribute Radar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Size ("Radar Size", Range(0, 1)) = 1
_AntiAliasStrength ("Anti-alias Strength (refer to texel size if be 1)", Range(0.01, 10)) = 1
_Attribute1 ("Attribute 1", Range(0.01, 1)) = 1
_Attribute2 ("Attribute 2", Range(0.01, 1)) = 1
_Attribute3 ("Attribute 3", Range(0.01, 1)) = 1
_Attribute4 ("Attribute 4", Range(0.01, 1)) = 1
_Attribute5 ("Attribute 5", Range(0.01, 1)) = 1
_Attribute6 ("Attribute 6", Range(0.01, 1)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 14611
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat0.x = _Attribute1;
    u_xlat2 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = u_xlat2 * _Attribute2;
    u_xlat1 = vec4(u_xlat2) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat0.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat1.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat1.z * float(-0.5), u_xlat1.z * float(-0.866024971), u_xlat1.w * float(0.5), u_xlat1.w * float(-0.866024971));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat12 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat12 = u_xlat8.x * u_xlat8.x;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb5 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb12 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8.x = u_xlat12 + u_xlat8.x;
    u_xlat12 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb12 = u_xlatb12 && u_xlatb1.x;
    u_xlat8.x = (u_xlatb12) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat1 = u_xlat8.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat8.xy = u_xlat8.xx + vec2(0.476392508, -0.570807457);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati8.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati8.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati8.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati8.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat5.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat5.xyz;
    u_xlat8.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat13 = u_xlat1.y * u_xlat8.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat13;
    u_xlat5.x = u_xlat0.y * u_xlat8.x;
    u_xlat5.x = u_xlat3.x * u_xlat0.x + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat5.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat12 = u_xlat8.y * u_xlat3.x + u_xlat5.y;
    u_xlat8.x = u_xlat8.x * u_xlat8.x + u_xlat5.x;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = max(u_xlat8.x, 0.00100000005);
    u_xlat8.x = u_xlat1.x / u_xlat8.x;
    u_xlat8.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat8.x;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = floor(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlati12 = int(u_xlat12);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = (-u_xlat5.x) * u_xlat8.x + 1.0;
    u_xlat5.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat5.xy;
    u_xlat13 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.xy;
    u_xlat5.xy = u_xlat5.xy * u_xlat5.xy;
    u_xlat5.x = u_xlat5.y + u_xlat5.x;
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat13) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat5.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
    u_xlat4 = min(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = (u_xlati12 != 0) ? u_xlat0.x : u_xlat4;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
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
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat0.x = _Attribute1;
    u_xlat2 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = u_xlat2 * _Attribute2;
    u_xlat1 = vec4(u_xlat2) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat0.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat1.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat1.z * float(-0.5), u_xlat1.z * float(-0.866024971), u_xlat1.w * float(0.5), u_xlat1.w * float(-0.866024971));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat12 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat12 = u_xlat8.x * u_xlat8.x;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb5 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb12 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8.x = u_xlat12 + u_xlat8.x;
    u_xlat12 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb12 = u_xlatb12 && u_xlatb1.x;
    u_xlat8.x = (u_xlatb12) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat1 = u_xlat8.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat8.xy = u_xlat8.xx + vec2(0.476392508, -0.570807457);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati8.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati8.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati8.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati8.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat5.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat5.xyz;
    u_xlat8.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat13 = u_xlat1.y * u_xlat8.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat13;
    u_xlat5.x = u_xlat0.y * u_xlat8.x;
    u_xlat5.x = u_xlat3.x * u_xlat0.x + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat5.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat12 = u_xlat8.y * u_xlat3.x + u_xlat5.y;
    u_xlat8.x = u_xlat8.x * u_xlat8.x + u_xlat5.x;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = max(u_xlat8.x, 0.00100000005);
    u_xlat8.x = u_xlat1.x / u_xlat8.x;
    u_xlat8.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat8.x;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = floor(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlati12 = int(u_xlat12);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = (-u_xlat5.x) * u_xlat8.x + 1.0;
    u_xlat5.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat5.xy;
    u_xlat13 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.xy;
    u_xlat5.xy = u_xlat5.xy * u_xlat5.xy;
    u_xlat5.x = u_xlat5.y + u_xlat5.x;
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat13) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat5.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
    u_xlat4 = min(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = (u_xlati12 != 0) ? u_xlat0.x : u_xlat4;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
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
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat0.x = _Attribute1;
    u_xlat2 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = u_xlat2 * _Attribute2;
    u_xlat1 = vec4(u_xlat2) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat0.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat1.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat1.z * float(-0.5), u_xlat1.z * float(-0.866024971), u_xlat1.w * float(0.5), u_xlat1.w * float(-0.866024971));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat12 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat12 = u_xlat8.x * u_xlat8.x;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb5 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb12 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8.x = u_xlat12 + u_xlat8.x;
    u_xlat12 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb12 = u_xlatb12 && u_xlatb1.x;
    u_xlat8.x = (u_xlatb12) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat1 = u_xlat8.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat8.xy = u_xlat8.xx + vec2(0.476392508, -0.570807457);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati8.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati8.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati8.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati8.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat5.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat5.xyz;
    u_xlat8.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat13 = u_xlat1.y * u_xlat8.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat13;
    u_xlat5.x = u_xlat0.y * u_xlat8.x;
    u_xlat5.x = u_xlat3.x * u_xlat0.x + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat5.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat12 = u_xlat8.y * u_xlat3.x + u_xlat5.y;
    u_xlat8.x = u_xlat8.x * u_xlat8.x + u_xlat5.x;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = max(u_xlat8.x, 0.00100000005);
    u_xlat8.x = u_xlat1.x / u_xlat8.x;
    u_xlat8.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat8.x;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = floor(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlati12 = int(u_xlat12);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat8.x * -2.0 + 3.0;
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat8.x = (-u_xlat5.x) * u_xlat8.x + 1.0;
    u_xlat5.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat5.xy;
    u_xlat13 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.xy;
    u_xlat5.xy = u_xlat5.xy * u_xlat5.xy;
    u_xlat5.x = u_xlat5.y + u_xlat5.x;
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat13) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat5.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat4) * u_xlat0.x + 1.0;
    u_xlat4 = min(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
    u_xlat0.x = (u_xlati12 != 0) ? u_xlat0.x : u_xlat4;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat1.x = _Attribute1;
    u_xlat4 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = u_xlat4 * _Attribute2;
    u_xlat2 = vec4(u_xlat4) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat1.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat2.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat2.z * float(-0.5), u_xlat2.z * float(-0.866024971), u_xlat2.w * float(0.5), u_xlat2.w * float(-0.866024971));
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
ivec2 u_xlati10;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat1.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat15 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat15 * u_xlat1.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat15 * u_xlat10.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb6 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb6 ? u_xlat1.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb15 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb15 = u_xlatb15 && u_xlatb1.x;
    u_xlat10.x = (u_xlatb15) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat1 = u_xlat10.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat10.xy = u_xlat10.xx + vec2(0.476392508, -0.570807457);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = max(u_xlat10.xy, vec2(0.0, 0.0));
    u_xlati10.xy = ivec2(u_xlat10.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati10.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati10.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati10.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati10.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat6.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat6.xyz;
    u_xlat10.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat16 = u_xlat1.y * u_xlat10.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat16;
    u_xlat6.x = u_xlat0.y * u_xlat10.x;
    u_xlat6.x = u_xlat3.x * u_xlat0.x + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat6.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat15 = u_xlat10.y * u_xlat3.x + u_xlat6.y;
    u_xlat10.x = u_xlat10.x * u_xlat10.x + u_xlat6.x;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = u_xlat1.x / u_xlat10.x;
    u_xlat10.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat10.x;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10.x = u_xlat10.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = (-u_xlat6.x) * u_xlat10.x + 1.0;
    u_xlat6.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat6.xy;
    u_xlat16 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * u_xlat6.xy;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat16) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat6.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5) * u_xlat0.x + 1.0;
    u_xlat5 = min(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = (u_xlati15 != 0) ? u_xlat0.x : u_xlat5;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_4 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z * u_xlat16_4;
    u_xlat16_4 = u_xlat16_1.w * u_xlat16_4;
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat1.x = _Attribute1;
    u_xlat4 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = u_xlat4 * _Attribute2;
    u_xlat2 = vec4(u_xlat4) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat1.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat2.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat2.z * float(-0.5), u_xlat2.z * float(-0.866024971), u_xlat2.w * float(0.5), u_xlat2.w * float(-0.866024971));
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
ivec2 u_xlati10;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat1.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat15 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat15 * u_xlat1.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat15 * u_xlat10.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb6 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb6 ? u_xlat1.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb15 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb15 = u_xlatb15 && u_xlatb1.x;
    u_xlat10.x = (u_xlatb15) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat1 = u_xlat10.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat10.xy = u_xlat10.xx + vec2(0.476392508, -0.570807457);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = max(u_xlat10.xy, vec2(0.0, 0.0));
    u_xlati10.xy = ivec2(u_xlat10.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati10.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati10.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati10.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati10.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat6.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat6.xyz;
    u_xlat10.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat16 = u_xlat1.y * u_xlat10.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat16;
    u_xlat6.x = u_xlat0.y * u_xlat10.x;
    u_xlat6.x = u_xlat3.x * u_xlat0.x + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat6.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat15 = u_xlat10.y * u_xlat3.x + u_xlat6.y;
    u_xlat10.x = u_xlat10.x * u_xlat10.x + u_xlat6.x;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = u_xlat1.x / u_xlat10.x;
    u_xlat10.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat10.x;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10.x = u_xlat10.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = (-u_xlat6.x) * u_xlat10.x + 1.0;
    u_xlat6.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat6.xy;
    u_xlat16 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * u_xlat6.xy;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat16) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat6.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5) * u_xlat0.x + 1.0;
    u_xlat5 = min(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = (u_xlati15 != 0) ? u_xlat0.x : u_xlat5;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_4 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z * u_xlat16_4;
    u_xlat16_4 = u_xlat16_1.w * u_xlat16_4;
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	float _Size;
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.y = 0.0;
    u_xlat1.x = _Attribute1;
    u_xlat4 = _Size * -0.5;
    vs_TEXCOORD1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = u_xlat4 * _Attribute2;
    u_xlat2 = vec4(u_xlat4) * vec4(_Attribute3, _Attribute4, _Attribute5, _Attribute6);
    vs_TEXCOORD1.zw = u_xlat1.xx * vec2(0.5, 0.866024971);
    vs_TEXCOORD2 = u_xlat2.xxyy * vec4(-0.5, 0.866024971, -1.0, 0.0);
    vs_TEXCOORD3 = vec4(u_xlat2.z * float(-0.5), u_xlat2.z * float(-0.866024971), u_xlat2.w * float(0.5), u_xlat2.w * float(-0.866024971));
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _AntiAliasStrength;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
ivec4 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
ivec2 u_xlati10;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.x), abs(u_xlat0.y));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat1.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat15 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat15 * u_xlat1.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat15 * u_xlat10.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
#else
    u_xlatb6 = abs(u_xlat0.x)<abs(u_xlat0.y);
#endif
    u_xlat1.x = u_xlatb6 ? u_xlat1.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.x<(-u_xlat0.x));
#else
    u_xlatb15 = u_xlat0.x<(-u_xlat0.x);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb15 = u_xlatb15 && u_xlatb1.x;
    u_xlat10.x = (u_xlatb15) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat1 = u_xlat10.xxxx + vec4(3.1415925, 3.6179924, 2.57079268, 1.52359247);
    u_xlat10.xy = u_xlat10.xx + vec2(0.476392508, -0.570807457);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = max(u_xlat10.xy, vec2(0.0, 0.0));
    u_xlati10.xy = ivec2(u_xlat10.xy);
    u_xlat1.x = (-u_xlat1.x) + 6.75960016;
    u_xlat1 = floor(u_xlat1);
    u_xlat1.zw = max(u_xlat1.zw, vec2(0.0, 0.0));
    u_xlati1 = ivec4(u_xlat1);
    u_xlatb1.xy = equal(u_xlati1.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb1.x = u_xlatb1.x || u_xlatb1.y;
    u_xlat2.xy = vs_TEXCOORD3.zw;
    u_xlat2.zw = vs_TEXCOORD1.xy;
    u_xlat2 = (u_xlati10.y != 0) ? u_xlat2 : vs_TEXCOORD3;
    u_xlat3.xy = vs_TEXCOORD2.zw;
    u_xlat3.zw = vs_TEXCOORD3.xy;
    u_xlat2 = (u_xlati10.x != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlati1.w != 0) ? u_xlat2 : vs_TEXCOORD2;
    u_xlat3.xy = vs_TEXCOORD1.zw;
    u_xlat3.zw = vs_TEXCOORD2.xy;
    u_xlat2 = (u_xlati1.z != 0) ? u_xlat2 : u_xlat3;
    u_xlat2 = (u_xlatb1.x) ? vs_TEXCOORD1 : u_xlat2;
    u_xlat3.xyz = (u_xlati10.y != 0) ? vs_TEXCOORD3.yyx : vs_TEXCOORD2.wwz;
    u_xlat3.xyz = (u_xlati10.x != 0) ? u_xlat3.xyz : vs_TEXCOORD2.yyx;
    u_xlat3.xyz = (u_xlati1.w != 0) ? u_xlat3.xyz : vs_TEXCOORD1.wwz;
    u_xlat6.xyz = (u_xlati1.z != 0) ? u_xlat3.xyz : vs_TEXCOORD1.yyx;
    u_xlat1.xyz = (u_xlatb1.x) ? vs_TEXCOORD3.wwz : u_xlat6.xyz;
    u_xlat10.xy = (-u_xlat2.xz) + u_xlat1.zz;
    u_xlat16 = u_xlat1.y * u_xlat10.x;
    u_xlat3.xyz = (-u_xlat1.xyz) + u_xlat2.ywx;
    u_xlat1.x = u_xlat3.x * u_xlat1.z + u_xlat16;
    u_xlat6.x = u_xlat0.y * u_xlat10.x;
    u_xlat6.x = u_xlat3.x * u_xlat0.x + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat6.xy = u_xlat3.xz * u_xlat3.xy;
    u_xlat15 = u_xlat10.y * u_xlat3.x + u_xlat6.y;
    u_xlat10.x = u_xlat10.x * u_xlat10.x + u_xlat6.x;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = u_xlat1.x / u_xlat10.x;
    u_xlat10.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat10.x;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat1.x = _AntiAliasStrength * _MainTex_TexelSize.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat10.x = u_xlat10.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat10.x * -2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = (-u_xlat6.x) * u_xlat10.x + 1.0;
    u_xlat6.xy = vec2((-u_xlat2.y) + u_xlat2.w, (-u_xlat2.z) + u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy * u_xlat6.xy;
    u_xlat16 = u_xlat2.y + u_xlat2.x;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * u_xlat6.xy;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = (-u_xlat16) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x / u_xlat6.x;
    u_xlat0.x = _MainTex_TexelSize.x * _AntiAliasStrength + u_xlat0.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5) * u_xlat0.x + 1.0;
    u_xlat5 = min(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = max(u_xlat0.x, u_xlat10.x);
    u_xlat0.x = (u_xlati15 != 0) ? u_xlat0.x : u_xlat5;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    SV_Target0.xyz = u_xlat16_1.xyz;
    u_xlat16_1 = vs_TEXCOORD5.xyxy / vs_TEXCOORD5.wwww;
    u_xlat16_1 = u_xlat16_1 + (-_RMRect);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_4 = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z * u_xlat16_4;
    u_xlat16_4 = u_xlat16_1.w * u_xlat16_4;
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}