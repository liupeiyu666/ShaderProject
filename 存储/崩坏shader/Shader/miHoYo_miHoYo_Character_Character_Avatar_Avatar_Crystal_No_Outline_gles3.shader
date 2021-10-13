//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Crystal_No_Outline" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex", 2D) = "white" { }
_RefractTex ("Refraction Texture", Cube) = "" { }
_BumpTex ("Frige Bump Tex", 2D) = "gray" { }
_BumpScaler ("Fringe Bump Scaler", Range(0, 10)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_Emission ("Emission", Range(1, 20)) = 1
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 65385
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 98472
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BumpTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec2 vs_COLOR1;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
bool u_xlatb8;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD2.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    u_xlat1.w = (-u_xlat1.y);
    u_xlat2.xy = u_xlat1.yx * vec2(-1.0, 1.0);
    u_xlat8 = dot(u_xlat1.wx, u_xlat2.xy);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.x = u_xlat8 * (-u_xlat1.y);
    u_xlat2.y = u_xlat8 * u_xlat1.x;
    u_xlat2.z = 0.0;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.zxy) * u_xlat2.yzx;
    u_xlat2.xyz = (-u_xlat1.yzx) * u_xlat2.zxy + (-u_xlat3.xyz);
    vs_TEXCOORD5.xyz = (-u_xlat1.xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    vs_TEXCOORD4.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    vs_COLOR1.x = 0.0;
    vs_COLOR1.y = _Opaqueness * 1.29999995;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump float _Emission;
uniform 	mediump float _BumpScaler;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpTex;
uniform lowp samplerCube _RefractTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec2 vs_COLOR1;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
bvec2 u_xlatb8;
float u_xlat12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_BumpTex, vs_TEXCOORD1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.0);
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_BumpScaler, _BumpScaler));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat2.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_RefractTex, u_xlat1.xyz).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3 = _Emission + _ReflectionStrength;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_3);
    SV_Target0.w = vs_COLOR1.y;
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
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 150222
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
CustomEditor "MoleMole.CharacterShaderEditorBase"
}