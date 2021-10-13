//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor_UI" {
Properties {
_MainTex ("Decal Texture", 2D) = "white" { }
_TintColor ("TintColor", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Enum(RGB,0,R,1,G,2,B,3,A,4,WhiteColor,5)] _BaseTexColorChannelToggle ("BaseTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _BaseTexAlphaChannelToggle ("BaseTexAlphaChannelToggle", Float) = 3
_clip ("Clip", Vector) = (0,1,0,0)
_UIMainTex ("UIMainTex", 2D) = "white" { }
_UISlide ("UISlide", Range(-0.2, 1.2)) = 0.01
_UISoftEdge ("UISoftEdge", Float) = 0.2
_UIEdgeWidth ("UIEdgeWidth", Float) = 0
_UIEdgeColor ("UIEdgeColor", Color) = (0,0,0,0)
_UIEdgeColorIntensity ("UIEdgeColor", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 12757
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
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _UISlide;
uniform 	vec4 _UIMainTex_ST;
uniform 	float _UIEdgeWidth;
uniform 	vec4 _UIEdgeColor;
uniform 	float _UIEdgeColorIntensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _UIMainTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
bool u_xlatb7;
vec2 u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_15;
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
    u_xlat0.xy = u_xlat0.zx + vec2(0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb10 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb10 = u_xlatb2.z || u_xlatb10;
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = 2.0 / u_xlat16_10;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_10);
    u_xlat1.z = u_xlat16_10 + -1.0;
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
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
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4.x = u_xlat16_4.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_4.x<0.0);
#else
    u_xlatb10 = u_xlat16_4.x<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat10.xy = u_xlat0.xy * _UIMainTex_ST.yx + _UIMainTex_ST.wz;
    u_xlat0.xy = u_xlat0.yx * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.xy = u_xlat10.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat2.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat2.x = u_xlat15 * u_xlat2.x + 0.180141002;
    u_xlat2.x = u_xlat15 * u_xlat2.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat2.x + 0.999866009;
    u_xlat2.x = u_xlat15 * u_xlat10.x;
    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb7 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb15 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb5.x = u_xlat15<(-u_xlat15);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb5.x;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
    u_xlat10_0 = texture(_UIMainTex, u_xlat0.xx).x;
    u_xlat5.x = (-_UIEdgeWidth) + 1.0;
    u_xlat5.x = u_xlat5.x * 0.00999999978 + _UISlide;
    u_xlat0.y = (-u_xlat5.x) + u_xlat10_0;
    u_xlat0.x = u_xlat10_0 + (-_UISlide);
    u_xlat0.xy = u_xlat0.xy * vec2(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat0.y * -2.0 + 3.0;
    u_xlat15 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat5.x = u_xlat10.x * u_xlat0.y + (-u_xlat0.x);
    u_xlat5.xyz = u_xlat5.xxx * _UIEdgeColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.x = u_xlat5.x * _UIEdgeColorIntensity + u_xlat0.x;
    u_xlatb5.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _TintColor.w;
    SV_Target0.w = u_xlat0.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _UISlide;
uniform 	vec4 _UIMainTex_ST;
uniform 	float _UIEdgeWidth;
uniform 	vec4 _UIEdgeColor;
uniform 	float _UIEdgeColorIntensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _UIMainTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
bool u_xlatb7;
vec2 u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_15;
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
    u_xlat0.xy = u_xlat0.zx + vec2(0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb10 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb10 = u_xlatb2.z || u_xlatb10;
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = 2.0 / u_xlat16_10;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_10);
    u_xlat1.z = u_xlat16_10 + -1.0;
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
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
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4.x = u_xlat16_4.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_4.x<0.0);
#else
    u_xlatb10 = u_xlat16_4.x<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat10.xy = u_xlat0.xy * _UIMainTex_ST.yx + _UIMainTex_ST.wz;
    u_xlat0.xy = u_xlat0.yx * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.xy = u_xlat10.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat2.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat2.x = u_xlat15 * u_xlat2.x + 0.180141002;
    u_xlat2.x = u_xlat15 * u_xlat2.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat2.x + 0.999866009;
    u_xlat2.x = u_xlat15 * u_xlat10.x;
    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb7 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb15 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb5.x = u_xlat15<(-u_xlat15);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb5.x;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
    u_xlat10_0 = texture(_UIMainTex, u_xlat0.xx).x;
    u_xlat5.x = (-_UIEdgeWidth) + 1.0;
    u_xlat5.x = u_xlat5.x * 0.00999999978 + _UISlide;
    u_xlat0.y = (-u_xlat5.x) + u_xlat10_0;
    u_xlat0.x = u_xlat10_0 + (-_UISlide);
    u_xlat0.xy = u_xlat0.xy * vec2(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat0.y * -2.0 + 3.0;
    u_xlat15 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat5.x = u_xlat10.x * u_xlat0.y + (-u_xlat0.x);
    u_xlat5.xyz = u_xlat5.xxx * _UIEdgeColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.x = u_xlat5.x * _UIEdgeColorIntensity + u_xlat0.x;
    u_xlatb5.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _TintColor.w;
    SV_Target0.w = u_xlat0.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _DepthScaleValue;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _UISlide;
uniform 	vec4 _UIMainTex_ST;
uniform 	float _UIEdgeWidth;
uniform 	vec4 _UIEdgeColor;
uniform 	float _UIEdgeColorIntensity;
uniform lowp sampler2D _CustomDepthNormalsTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _UIMainTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
bool u_xlatb7;
vec2 u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_15;
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
    u_xlat0.xy = u_xlat0.zx + vec2(0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb10 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb10 = u_xlatb2.z || u_xlatb10;
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = 2.0 / u_xlat16_10;
    u_xlat1.xy = u_xlat16_1.xy * vec2(u_xlat16_10);
    u_xlat1.z = u_xlat16_10 + -1.0;
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
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
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.x = dot(u_xlat1.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_4.x = u_xlat16_4.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_4.x<0.0);
#else
    u_xlatb10 = u_xlat16_4.x<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat10.xy = u_xlat0.xy * _UIMainTex_ST.yx + _UIMainTex_ST.wz;
    u_xlat0.xy = u_xlat0.yx * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.xy = u_xlat10.xy + vec2(-0.5, -0.5);
    u_xlat10.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat2.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat2.x = u_xlat15 * u_xlat2.x + 0.180141002;
    u_xlat2.x = u_xlat15 * u_xlat2.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat2.x + 0.999866009;
    u_xlat2.x = u_xlat15 * u_xlat10.x;
    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb7 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb15 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb5.x = u_xlat15<(-u_xlat15);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb5.x;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
    u_xlat10_0 = texture(_UIMainTex, u_xlat0.xx).x;
    u_xlat5.x = (-_UIEdgeWidth) + 1.0;
    u_xlat5.x = u_xlat5.x * 0.00999999978 + _UISlide;
    u_xlat0.y = (-u_xlat5.x) + u_xlat10_0;
    u_xlat0.x = u_xlat10_0 + (-_UISlide);
    u_xlat0.xy = u_xlat0.xy * vec2(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat0.y * -2.0 + 3.0;
    u_xlat15 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat5.x = u_xlat10.x * u_xlat0.y + (-u_xlat0.x);
    u_xlat5.xyz = u_xlat5.xxx * _UIEdgeColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle), vec4(4.0, 5.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb2.y) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat16_4.x;
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle, _BaseTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.x = u_xlat5.x * _UIEdgeColorIntensity + u_xlat0.x;
    u_xlatb5.xy = equal(vec4(vec4(_BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle, _BaseTexAlphaChannelToggle)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _TintColor.w;
    SV_Target0.w = u_xlat0.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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