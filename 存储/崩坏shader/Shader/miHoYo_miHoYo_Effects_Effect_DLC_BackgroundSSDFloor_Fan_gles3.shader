//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor_Fan" {
Properties {
_MainTex ("Decal Texture", 2D) = "white" { }
_TintColor ("TintColor", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Enum(RGB,0,R,1,G,2,B,3,A,4,WhiteColor,5)] _BaseTexColorChannelToggle ("BaseTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _BaseTexAlphaChannelToggle ("BaseTexAlphaChannelToggle", Float) = 3
_MaskTexture ("MaskTexture", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelToggle ("MaskTexChannelToggle", Float) = 0
_DetailColor ("DetailColor", Color) = (0,0,0,0)
_DetailTex ("DetailTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DetailTexColorChannelToggle ("DetailTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _DetailTexAlphaChannelToggle ("DetailTexAlpgaChannelToggle", Float) = 3
_DetailTex_Uspeed ("DetailTex_Uspeed", Float) = 0
_DetailTex_Vspeed ("DetailTex_Vspeed", Float) = 0
_clip ("Clip", Vector) = (0,1,0,0)
_FanAngle ("Fan Angle", Range(0.1, 6.28318)) = 1.57
_BorderAngle ("Border Triangle Angle", Range(0, 0.3)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 53364
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3 * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3 * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3 * u_xlat6 + -0.330299497;
    u_xlat3 = u_xlat3 * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3 * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb9 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3 + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb3 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat3 = u_xlatb3 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3 + u_xlat0.x;
    u_xlat3 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3<(-u_xlat3));
#else
    u_xlatb3 = u_xlat3<(-u_xlat3);
#endif
    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3 = (-_BorderAngle) + 3.14159012;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat0.x + u_xlat9;
    u_xlat0.x = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = u_xlat1.x / u_xlat3;
    u_xlat0.x = (u_xlati6 != 0) ? u_xlat0.x : u_xlat3;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD4 = 0.0;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_14;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bvec2 u_xlatb16;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_24 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_24 = u_xlat16_24 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat8.xz = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat8.xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat16.x = -abs(u_xlat0.x) + 1.5;
    u_xlat16.x = floor(u_xlat16.x);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlati16 = int(u_xlat16.x);
    if((u_xlati16)==0){discard;}
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = 2.0 / u_xlat16_16;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_16);
    u_xlat1.z = u_xlat16_16 + -1.0;
    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat1.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati16 = int(u_xlat16_5.x);
    if((u_xlati16)==0){discard;}
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat16.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_5.x = (u_xlatb3.y) ? 1.0 : 0.0;
    u_xlat16_5.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_5.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_5.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle), vec4(2.0, 3.0, 0.0, 1.0));
    u_xlat16_29 = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_29 = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16_29;
    u_xlat16.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat16.xy);
    u_xlatb16.xy = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_6 = (u_xlatb16.y) ? u_xlat1.w : 0.0;
    u_xlat16_6 = (u_xlatb16.x) ? u_xlat1.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_6;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_7.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_7.xy);
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_14 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_14;
    u_xlatb1 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_7.xyz = vec3(u_xlat16_14) * _DetailColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _TintColor.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler);
    u_xlat16_5.x = u_xlat16_29 * _TintColor.w;
    u_xlat16_5.x = u_xlat16_6 * u_xlat16_5.x;
    u_xlat16_0 = u_xlat16_22 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3 * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3 * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3 * u_xlat6 + -0.330299497;
    u_xlat3 = u_xlat3 * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3 * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb9 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3 + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb3 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat3 = u_xlatb3 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3 + u_xlat0.x;
    u_xlat3 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3<(-u_xlat3));
#else
    u_xlatb3 = u_xlat3<(-u_xlat3);
#endif
    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3 = (-_BorderAngle) + 3.14159012;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat0.x + u_xlat9;
    u_xlat0.x = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = u_xlat1.x / u_xlat3;
    u_xlat0.x = (u_xlati6 != 0) ? u_xlat0.x : u_xlat3;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD4 = 0.0;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_14;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bvec2 u_xlatb16;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_24 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_24 = u_xlat16_24 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat8.xz = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat8.xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat16.x = -abs(u_xlat0.x) + 1.5;
    u_xlat16.x = floor(u_xlat16.x);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlati16 = int(u_xlat16.x);
    if((u_xlati16)==0){discard;}
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = 2.0 / u_xlat16_16;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_16);
    u_xlat1.z = u_xlat16_16 + -1.0;
    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat1.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati16 = int(u_xlat16_5.x);
    if((u_xlati16)==0){discard;}
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat16.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_5.x = (u_xlatb3.y) ? 1.0 : 0.0;
    u_xlat16_5.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_5.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_5.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle), vec4(2.0, 3.0, 0.0, 1.0));
    u_xlat16_29 = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_29 = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16_29;
    u_xlat16.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat16.xy);
    u_xlatb16.xy = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_6 = (u_xlatb16.y) ? u_xlat1.w : 0.0;
    u_xlat16_6 = (u_xlatb16.x) ? u_xlat1.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_6;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_7.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_7.xy);
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_14 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_14;
    u_xlatb1 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_7.xyz = vec3(u_xlat16_14) * _DetailColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _TintColor.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler);
    u_xlat16_5.x = u_xlat16_29 * _TintColor.w;
    u_xlat16_5.x = u_xlat16_6 * u_xlat16_5.x;
    u_xlat16_0 = u_xlat16_22 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FanAngle;
uniform 	float _BorderAngle;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3 = min(abs(in_POSITION0.z), abs(in_POSITION0.x));
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3 * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3 * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3 * u_xlat6 + -0.330299497;
    u_xlat3 = u_xlat3 * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3 * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(in_POSITION0.z)<abs(in_POSITION0.x));
#else
    u_xlatb9 = abs(in_POSITION0.z)<abs(in_POSITION0.x);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3 + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(in_POSITION0.z<(-in_POSITION0.z));
#else
    u_xlatb3 = in_POSITION0.z<(-in_POSITION0.z);
#endif
    u_xlat3 = u_xlatb3 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3 + u_xlat0.x;
    u_xlat3 = min(in_POSITION0.z, abs(in_POSITION0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3<(-u_xlat3));
#else
    u_xlatb3 = u_xlat3<(-u_xlat3);
#endif
    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3 = (-_BorderAngle) + 3.14159012;
    u_xlat6 = (-u_xlat3) + u_xlat0.x;
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = _FanAngle * 0.5 + (-_BorderAngle);
    u_xlat1.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat0.x + u_xlat9;
    u_xlat0.x = (-u_xlat3) + u_xlat0.x;
    u_xlat3 = u_xlat1.x / u_xlat3;
    u_xlat0.x = (u_xlati6 != 0) ? u_xlat0.x : u_xlat3;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3 = in_POSITION0.x / abs(in_POSITION0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat1.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD4 = 0.0;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_14;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bvec2 u_xlatb16;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_24 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_24 = u_xlat16_24 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat8.xz = u_xlat0.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat8.xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat16.x = -abs(u_xlat0.x) + 1.5;
    u_xlat16.x = floor(u_xlat16.x);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlati16 = int(u_xlat16.x);
    if((u_xlati16)==0){discard;}
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_16 = 2.0 / u_xlat16_16;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_16);
    u_xlat1.z = u_xlat16_16 + -1.0;
    u_xlat16.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat1.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = inversesqrt(u_xlat16.x);
    u_xlat1.xyz = u_xlat16.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati16 = int(u_xlat16_5.x);
    if((u_xlati16)==0){discard;}
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat16.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_5.x = (u_xlatb3.y) ? 1.0 : 0.0;
    u_xlat16_5.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_5.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_5.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle), vec4(2.0, 3.0, 0.0, 1.0));
    u_xlat16_29 = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_29 = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16_29;
    u_xlat16_29 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16_29;
    u_xlat16.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat16.xy);
    u_xlatb16.xy = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_6 = (u_xlatb16.y) ? u_xlat1.w : 0.0;
    u_xlat16_6 = (u_xlatb16.x) ? u_xlat1.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_6;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_7.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_7.xy);
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_14 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_14 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_14;
    u_xlat16_14 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_14;
    u_xlatb1 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_7.xyz = vec3(u_xlat16_14) * _DetailColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _TintColor.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler);
    u_xlat16_5.x = u_xlat16_29 * _TintColor.w;
    u_xlat16_5.x = u_xlat16_6 * u_xlat16_5.x;
    u_xlat16_0 = u_xlat16_22 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0;
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
  GpuProgramID 72136
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + 0.99000001;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati0 = int(u_xlat16_1);
    if((u_xlati0)==0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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