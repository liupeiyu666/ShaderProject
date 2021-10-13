//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor" {
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
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 23696
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
vec2 u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat18 = dot(u_xlat1.zw, vec2(1.0, 0.00392156886));
    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat18 = u_xlat18 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb12.x = u_xlatb2.y || u_xlatb2.x;
    u_xlatb12.x = u_xlatb2.z || u_xlatb12.x;
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = 2.0 / u_xlat12.x;
    u_xlat1.xy = u_xlat1.xy * u_xlat12.xx;
    u_xlat1.z = u_xlat12.x + -1.0;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat12.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12.x = u_xlat12.x + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat12.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat12.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat12.xy);
    u_xlatb12.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_10 = (u_xlatb12.y) ? u_xlat1.w : 0.0;
    u_xlat16_10 = (u_xlatb12.x) ? u_xlat1.z : u_xlat16_10;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_10 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_10;
    u_xlat16_10 = u_xlat16_10 * _TintColor.w;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10;
    u_xlat16_5.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_5.xy);
    u_xlatb3 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_10 = (u_xlatb3.w) ? u_xlat0.w : 0.0;
    u_xlat16_10 = (u_xlatb3.z) ? u_xlat0.z : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.y) ? u_xlat0.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.x) ? u_xlat0.x : u_xlat16_10;
    SV_Target0.w = u_xlat16_10 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_5.xyz = vec3(u_xlat16_22) * _DetailColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
vec2 u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat18 = dot(u_xlat1.zw, vec2(1.0, 0.00392156886));
    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat18 = u_xlat18 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb12.x = u_xlatb2.y || u_xlatb2.x;
    u_xlatb12.x = u_xlatb2.z || u_xlatb12.x;
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = 2.0 / u_xlat12.x;
    u_xlat1.xy = u_xlat1.xy * u_xlat12.xx;
    u_xlat1.z = u_xlat12.x + -1.0;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat12.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12.x = u_xlat12.x + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat12.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat12.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat12.xy);
    u_xlatb12.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_10 = (u_xlatb12.y) ? u_xlat1.w : 0.0;
    u_xlat16_10 = (u_xlatb12.x) ? u_xlat1.z : u_xlat16_10;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_10 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_10;
    u_xlat16_10 = u_xlat16_10 * _TintColor.w;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10;
    u_xlat16_5.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_5.xy);
    u_xlatb3 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_10 = (u_xlatb3.w) ? u_xlat0.w : 0.0;
    u_xlat16_10 = (u_xlatb3.z) ? u_xlat0.z : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.y) ? u_xlat0.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.x) ? u_xlat0.x : u_xlat16_10;
    SV_Target0.w = u_xlat16_10 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_5.xyz = vec3(u_xlat16_22) * _DetailColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _MaskTexChannelToggle;
uniform 	vec4 _MaskTexture_ST;
uniform 	mediump vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelToggle;
uniform 	mediump float _DetailTexAlphaChannelToggle;
uniform 	mediump float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _DetailTex_Vspeed;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTexture;
uniform lowp sampler2D _DetailTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
vec2 u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat1 = texture(_CustomDepthNormalsTexture, u_xlat1.xy);
    u_xlat18 = dot(u_xlat1.zw, vec2(1.0, 0.00392156886));
    u_xlat1.xyz = u_xlat1.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat18 = u_xlat18 * _DepthScaleValue;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb12.x = u_xlatb2.y || u_xlatb2.x;
    u_xlatb12.x = u_xlatb2.z || u_xlatb12.x;
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = 2.0 / u_xlat12.x;
    u_xlat1.xy = u_xlat1.xy * u_xlat12.xx;
    u_xlat1.z = u_xlat12.x + -1.0;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat3.xyz;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat3.xyz;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat12.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat12.x = u_xlat12.x + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat12.x<0.0);
#else
    u_xlatb12.x = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat12.xy = u_xlat0.xy * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
    u_xlat1 = texture(_MaskTexture, u_xlat12.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle, _MaskTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat12.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat12.xy);
    u_xlatb12.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 2.0, 3.0)).xy;
    u_xlat16_10 = (u_xlatb12.y) ? u_xlat1.w : 0.0;
    u_xlat16_10 = (u_xlatb12.x) ? u_xlat1.z : u_xlat16_10;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_10 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_10;
    u_xlat16_10 = u_xlat16_10 * _TintColor.w;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10;
    u_xlat16_5.x = _Time.y * _DetailTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DetailTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DetailTex, u_xlat16_5.xy);
    u_xlatb3 = equal(vec4(vec4(_DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle, _DetailTexAlphaChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_10 = (u_xlatb3.w) ? u_xlat0.w : 0.0;
    u_xlat16_10 = (u_xlatb3.z) ? u_xlat0.z : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.y) ? u_xlat0.y : u_xlat16_10;
    u_xlat16_10 = (u_xlatb3.x) ? u_xlat0.x : u_xlat16_10;
    SV_Target0.w = u_xlat16_10 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_22 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_22 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_22;
    u_xlat16_22 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_22;
    u_xlat16_5.xyz = vec3(u_xlat16_22) * _DetailColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz;
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
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 77375
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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