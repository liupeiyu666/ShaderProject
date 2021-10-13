//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part NoZTest NoBloom" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ColorToOffset ("Color To Tune", Color) = (0,0,0,0)
_ColorTolerance ("Color Tolerance", Range(0.01, 1)) = 0
_HueOffset ("Hue Offset", Range(0, 1)) = 0
_SaturateOffset ("Satureate Offset", Range(-1, 1)) = 0
_ValueOffset ("Value Offset", Range(-1, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Offset -20, -20
  GpuProgramID 22430
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD1.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD1.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD2.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
ivec4 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb12;
mediump float u_xlat16_14;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0.x = int(u_xlat0.x);
            if((u_xlati0.x)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati1) != 0) ? u_xlat10_0.xy : u_xlat10_0.yx;
    u_xlat16_14 = (-u_xlat10_0.z) + u_xlat16_2.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
    u_xlat16_14 = floor(u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlati1 = int(u_xlat16_14);
    u_xlat16_3.z = (u_xlati1 != 0) ? u_xlat16_2.y : u_xlat10_0.z;
    u_xlat16_8.x = u_xlat10_0.z + (-u_xlat16_2.x);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_2.x = (u_xlati1 != 0) ? u_xlat16_2.x : u_xlat10_0.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.z;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.z;
    u_xlat16_8.xyz = (-u_xlat10_0.yzx) + u_xlat16_3.zzz;
    u_xlat16_21 = u_xlat16_2.x * 6.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_21);
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-u_xlat16_3.zzz);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_5.xyz = floor(u_xlat16_5.xyz);
    u_xlat16_20 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16.xy = u_xlat16_2.zx + vec2(0.333333343, 0.666666687);
    u_xlati0.xyz = ivec3(u_xlat16_5.xyz);
    u_xlat16_2.xy = vec2((-u_xlat16_2.y) + u_xlat16_16.x, (-u_xlat16_2.z) + u_xlat16_16.y);
    u_xlat16_8.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_2.y;
    u_xlat16_2.x = (u_xlati0.y != 0) ? u_xlat16_8.x : u_xlat16_2.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_2.x : u_xlat16_20;
    u_xlat16_3.xy = (int(u_xlati1) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_2.xyz = u_xlat16_3.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = ceil(u_xlat16_2.x);
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyw = u_xlat16_2.xxx * u_xlat16_3.yzx + u_xlat16_8.yzx;
    u_xlat16_2.x = u_xlat16_1.w * 6.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_8.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.y = u_xlat16_1.y * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_1.w * 6.0 + (-u_xlat16_2.x);
    u_xlat16_8.y = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_8.yx;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati0.x = int(u_xlat16_8.x);
    u_xlat16_2 = u_xlat16_2.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2 = abs(u_xlat16_2) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati2 = ivec4(u_xlat16_2);
    u_xlat16_3.xz = (u_xlati2.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_3.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat16_3.xyz = (u_xlati2.y != 0) ? u_xlat16_3.xyz : u_xlat16_1.xzw;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.yzx;
    u_xlat16_3.xyz = (u_xlati0.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.zwx;
    u_xlat0.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    SV_Target0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat16_3.x = u_xlat10_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD1.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD1.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD2.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
ivec4 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb12;
mediump float u_xlat16_14;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0.x = int(u_xlat0.x);
            if((u_xlati0.x)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati1) != 0) ? u_xlat10_0.xy : u_xlat10_0.yx;
    u_xlat16_14 = (-u_xlat10_0.z) + u_xlat16_2.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
    u_xlat16_14 = floor(u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlati1 = int(u_xlat16_14);
    u_xlat16_3.z = (u_xlati1 != 0) ? u_xlat16_2.y : u_xlat10_0.z;
    u_xlat16_8.x = u_xlat10_0.z + (-u_xlat16_2.x);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_2.x = (u_xlati1 != 0) ? u_xlat16_2.x : u_xlat10_0.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.z;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.z;
    u_xlat16_8.xyz = (-u_xlat10_0.yzx) + u_xlat16_3.zzz;
    u_xlat16_21 = u_xlat16_2.x * 6.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_21);
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-u_xlat16_3.zzz);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_5.xyz = floor(u_xlat16_5.xyz);
    u_xlat16_20 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16.xy = u_xlat16_2.zx + vec2(0.333333343, 0.666666687);
    u_xlati0.xyz = ivec3(u_xlat16_5.xyz);
    u_xlat16_2.xy = vec2((-u_xlat16_2.y) + u_xlat16_16.x, (-u_xlat16_2.z) + u_xlat16_16.y);
    u_xlat16_8.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_2.y;
    u_xlat16_2.x = (u_xlati0.y != 0) ? u_xlat16_8.x : u_xlat16_2.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_2.x : u_xlat16_20;
    u_xlat16_3.xy = (int(u_xlati1) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_2.xyz = u_xlat16_3.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = ceil(u_xlat16_2.x);
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyw = u_xlat16_2.xxx * u_xlat16_3.yzx + u_xlat16_8.yzx;
    u_xlat16_2.x = u_xlat16_1.w * 6.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_8.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.y = u_xlat16_1.y * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_1.w * 6.0 + (-u_xlat16_2.x);
    u_xlat16_8.y = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_8.yx;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati0.x = int(u_xlat16_8.x);
    u_xlat16_2 = u_xlat16_2.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2 = abs(u_xlat16_2) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati2 = ivec4(u_xlat16_2);
    u_xlat16_3.xz = (u_xlati2.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_3.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat16_3.xyz = (u_xlati2.y != 0) ? u_xlat16_3.xyz : u_xlat16_1.xzw;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.yzx;
    u_xlat16_3.xyz = (u_xlati0.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.zwx;
    u_xlat0.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    SV_Target0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat16_3.x = u_xlat10_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec3 _ColorToOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
ivec3 u_xlati1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
int u_xlati8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_14;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = (-_ColorToOffset.x) + _ColorToOffset.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati8 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati8) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
    u_xlat16_10.x = (-u_xlat16_2.x) + _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_2.x = (u_xlati8 != 0) ? u_xlat16_2.x : _ColorToOffset.z;
    u_xlat16_10.x = u_xlat16_2.y + (-_ColorToOffset.z);
    u_xlat16_10.x = u_xlat16_10.x + 1.0;
    u_xlat16_10.x = floor(u_xlat16_10.x);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlati8 = int(u_xlat16_10.x);
    u_xlat16_6 = (u_xlati8 != 0) ? u_xlat16_2.y : _ColorToOffset.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_6;
    u_xlat16_3.xyz = vec3(u_xlat16_6) + (-_ColorToOffset.yzx);
    u_xlat16_3.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_10.x = u_xlat16_2.x * 6.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz / u_xlat16_10.xxx;
    u_xlat16_10.xy = u_xlat16_3.zx + vec2(0.333333343, 0.666666687);
    u_xlat16_10.xy = vec2((-u_xlat16_3.y) + u_xlat16_10.x, (-u_xlat16_3.z) + u_xlat16_10.y);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = (-vec3(u_xlat16_6)) + _ColorToOffset.xyz;
    u_xlat16_7.xyz = abs(u_xlat16_7.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_7.xyz = floor(u_xlat16_7.xyz);
    u_xlati1.xyz = ivec3(u_xlat16_7.xyz);
    u_xlat16_14 = (u_xlati1.z != 0) ? 0.0 : u_xlat16_10.y;
    u_xlat16_10.x = (u_xlati1.y != 0) ? u_xlat16_14 : u_xlat16_10.x;
    u_xlat16_3.x = (u_xlati1.x != 0) ? u_xlat16_10.x : u_xlat16_3.x;
    u_xlat16_3.y = u_xlat16_2.x / u_xlat16_6;
    vs_TEXCOORD1.z = u_xlat16_6;
    u_xlat16_2.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlati8 = int(u_xlat16_2.x);
    vs_TEXCOORD1.xy = (int(u_xlati8) != 0) ? u_xlat16_3.xy : vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD2.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec4 u_xlat16_2;
ivec4 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb12;
mediump float u_xlat16_14;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0.x = int(u_xlat0.x);
            if((u_xlati0.x)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = (-u_xlat10_0.x) + u_xlat10_0.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xy = (int(u_xlati1) != 0) ? u_xlat10_0.xy : u_xlat10_0.yx;
    u_xlat16_14 = (-u_xlat10_0.z) + u_xlat16_2.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
    u_xlat16_14 = floor(u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlati1 = int(u_xlat16_14);
    u_xlat16_3.z = (u_xlati1 != 0) ? u_xlat16_2.y : u_xlat10_0.z;
    u_xlat16_8.x = u_xlat10_0.z + (-u_xlat16_2.x);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_2.x = (u_xlati1 != 0) ? u_xlat16_2.x : u_xlat10_0.z;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_3.z;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati1 = int(u_xlat16_8.x);
    u_xlat16_4.y = u_xlat16_2.x / u_xlat16_3.z;
    u_xlat16_8.xyz = (-u_xlat10_0.yzx) + u_xlat16_3.zzz;
    u_xlat16_21 = u_xlat16_2.x * 6.0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * vec3(3.0, 3.0, 3.0) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_21);
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-u_xlat16_3.zzz);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_5.xyz = floor(u_xlat16_5.xyz);
    u_xlat16_20 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16.xy = u_xlat16_2.zx + vec2(0.333333343, 0.666666687);
    u_xlati0.xyz = ivec3(u_xlat16_5.xyz);
    u_xlat16_2.xy = vec2((-u_xlat16_2.y) + u_xlat16_16.x, (-u_xlat16_2.z) + u_xlat16_16.y);
    u_xlat16_8.x = (u_xlati0.z != 0) ? 0.0 : u_xlat16_2.y;
    u_xlat16_2.x = (u_xlati0.y != 0) ? u_xlat16_8.x : u_xlat16_2.x;
    u_xlat16_4.x = (u_xlati0.x != 0) ? u_xlat16_2.x : u_xlat16_20;
    u_xlat16_3.xy = (int(u_xlati1) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_2.xyz = u_xlat16_3.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = ceil(u_xlat16_2.x);
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyw = u_xlat16_2.xxx * u_xlat16_3.yzx + u_xlat16_8.yzx;
    u_xlat16_2.x = u_xlat16_1.w * 6.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_8.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.y = u_xlat16_1.y * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_1.w * 6.0 + (-u_xlat16_2.x);
    u_xlat16_8.y = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = (-u_xlat16_1.x) * u_xlat16_8.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_8.yx;
    u_xlat16_8.x = abs(u_xlat16_2.x) + 0.999000013;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlati0.x = int(u_xlat16_8.x);
    u_xlat16_2 = u_xlat16_2.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_2 = abs(u_xlat16_2) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati2 = ivec4(u_xlat16_2);
    u_xlat16_3.xz = (u_xlati2.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_3.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    u_xlat16_3.xyz = (u_xlati2.y != 0) ? u_xlat16_3.xyz : u_xlat16_1.xzw;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.yzx;
    u_xlat16_3.xyz = (u_xlati0.x != 0) ? u_xlat16_3.xyz : u_xlat16_1.zwx;
    u_xlat0.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    SV_Target0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat16_3.x = u_xlat10_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
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
Fallback "Diffuse"
}