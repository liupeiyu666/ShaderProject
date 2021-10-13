//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Dis_SSDF" {
Properties {
_MaskTex ("MaskTex", 2D) = "white" { }
_Cutoff ("Alpha Cutoff", Range(0, 2)) = 0.5
[Toggle] _CutOffFlip ("CutOffFlip", Float) = 0
_Color0 ("MainColor", Color) = (1,1,1,1)
_Intensity ("Intensity", Float) = 1
_clip ("Clip", Vector) = (0,1,0,0)
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
  ZWrite Off
  GpuProgramID 29490
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int _CutOffFlip;
uniform 	mediump float _DepthScaleValue;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Cutoff;
uniform 	vec4 _Color0;
uniform 	float _Intensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_15 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_15 = u_xlat16_15 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat0.xz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0.xyz = texture(_MaskTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb15 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb15 = u_xlatb2.z || u_xlatb15;
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_15 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_15 = 2.0 / u_xlat16_15;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_15);
    u_xlat1.z = u_xlat16_15 + -1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4 = u_xlat16_4 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_4 = u_xlat16_0.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = _CutOffFlip!=0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((_CutOffFlip!=0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati15 = u_xlatb15 ? u_xlati1 : int(0);
    u_xlati1 = ~u_xlati1;
    if((u_xlati15)!=0){discard;}
    u_xlat16_4 = (-u_xlat16_0.x) + _Cutoff;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    SV_Target0.xyz = u_xlat0.xyz * _Color0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    u_xlati0 = u_xlatb0 ? u_xlati1 : int(0);
    if((u_xlati0)!=0){discard;}
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int _CutOffFlip;
uniform 	mediump float _DepthScaleValue;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Cutoff;
uniform 	vec4 _Color0;
uniform 	float _Intensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_15 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_15 = u_xlat16_15 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat0.xz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0.xyz = texture(_MaskTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb15 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb15 = u_xlatb2.z || u_xlatb15;
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_15 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_15 = 2.0 / u_xlat16_15;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_15);
    u_xlat1.z = u_xlat16_15 + -1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4 = u_xlat16_4 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_4 = u_xlat16_0.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = _CutOffFlip!=0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((_CutOffFlip!=0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati15 = u_xlatb15 ? u_xlati1 : int(0);
    u_xlati1 = ~u_xlati1;
    if((u_xlati15)!=0){discard;}
    u_xlat16_4 = (-u_xlat16_0.x) + _Cutoff;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    SV_Target0.xyz = u_xlat0.xyz * _Color0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    u_xlati0 = u_xlatb0 ? u_xlati1 : int(0);
    if((u_xlati0)!=0){discard;}
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 _clip;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _clip.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _clip.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _clip.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int _CutOffFlip;
uniform 	mediump float _DepthScaleValue;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Cutoff;
uniform 	vec4 _Color0;
uniform 	float _Intensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat16_15 = dot(u_xlat10_1.zw, vec2(1.0, 0.00392156886));
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_15 = u_xlat16_15 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat0.xz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0.xyz = texture(_MaskTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb15 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb15 = u_xlatb2.z || u_xlatb15;
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_15 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_15 = 2.0 / u_xlat16_15;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_15);
    u_xlat1.z = u_xlat16_15 + -1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4 = u_xlat16_4 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat16_4 = u_xlat16_0.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_4<0.0);
#else
    u_xlatb15 = u_xlat16_4<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = _CutOffFlip!=0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((_CutOffFlip!=0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati15 = u_xlatb15 ? u_xlati1 : int(0);
    u_xlati1 = ~u_xlati1;
    if((u_xlati15)!=0){discard;}
    u_xlat16_4 = (-u_xlat16_0.x) + _Cutoff;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_Intensity);
    SV_Target0.xyz = u_xlat0.xyz * _Color0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    u_xlati0 = u_xlatb0 ? u_xlati1 : int(0);
    if((u_xlati0)!=0){discard;}
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
}
}
}
}