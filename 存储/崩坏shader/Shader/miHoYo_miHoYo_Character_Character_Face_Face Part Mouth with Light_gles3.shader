//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part Mouth with Light" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_Blend ("Switch to closed mouth textures", Range(0, 1)) = 0
_MainTex ("Main Mouth (RGB)", 2D) = "white" { }
_ClosedMouthTex ("Closed Mouth (RGB)", 2D) = "white" { }
_ColorToOffset ("Color To Tune", Color) = (0,0,0,0)
_ColorTolerance ("Color Tolerance", Range(0.01, 1)) = 0
_HueOffset ("Hue Offset", Range(0, 1)) = 0
_SaturateOffset ("Satureate Offset", Range(-1, 1)) = 0
_ValueOffset ("Value Offset", Range(-1, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Offset -2, -2
  GpuProgramID 26170
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _Blend;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _ClosedMouthTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
ivec4 u_xlati3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_8;
ivec3 u_xlati9;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb16;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedMouthTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz;
        u_xlat16_21 = u_xlat10_0.w;
    } else {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_2.xyz;
        u_xlat16_21 = u_xlat10_2.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_22 = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_4.xy = (int(u_xlati2) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_22 = (-u_xlat16_1.z) + u_xlat16_4.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_5.z = (u_xlati2 != 0) ? u_xlat16_4.y : u_xlat16_1.z;
    u_xlat16_22 = u_xlat16_1.z + (-u_xlat16_4.x);
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_22 = (u_xlati2 != 0) ? u_xlat16_4.x : u_xlat16_1.z;
    u_xlat16_22 = (-u_xlat16_22) + u_xlat16_5.z;
    u_xlat16_4.x = abs(u_xlat16_22) + 0.999000013;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.y = u_xlat16_22 / u_xlat16_5.z;
    u_xlat16_6.xyz = (-u_xlat16_1.yzx) + u_xlat16_5.zzz;
    u_xlat16_18.x = u_xlat16_22 * 6.0;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * vec3(3.0, 3.0, 3.0) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz / u_xlat16_18.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_5.zzz);
    u_xlat16_1.xyz = abs(u_xlat16_1.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_1.xyz = floor(u_xlat16_1.xyz);
    u_xlat16_22 = (-u_xlat16_6.x) + u_xlat16_6.y;
    u_xlat16_18.xy = u_xlat16_6.zx + vec2(0.333333343, 0.666666687);
    u_xlati9.xyz = ivec3(u_xlat16_1.xyz);
    u_xlat16_1.xy = vec2((-u_xlat16_6.y) + u_xlat16_18.x, (-u_xlat16_6.z) + u_xlat16_18.y);
    u_xlat16_8.x = (u_xlati9.z != 0) ? 0.0 : u_xlat16_1.y;
    u_xlat16_1.x = (u_xlati9.y != 0) ? u_xlat16_8.x : u_xlat16_1.x;
    u_xlat16_4.x = (u_xlati9.x != 0) ? u_xlat16_1.x : u_xlat16_22;
    u_xlat16_5.xy = (int(u_xlati2) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_8.xyz = u_xlat16_5.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = ceil(u_xlat16_1.x);
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.yzx + u_xlat16_8.yzx;
    u_xlat16_4.x = u_xlat16_1.w * 6.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_11.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_5.y = u_xlat16_1.y * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_1.w * 6.0 + (-u_xlat16_4.x);
    u_xlat16_11.y = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_11.x = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_11.yx;
    u_xlat16_11.x = abs(u_xlat16_4.x) + 0.999000013;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlati2 = int(u_xlat16_11.x);
    u_xlat16_3 = u_xlat16_4.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_3 = abs(u_xlat16_3) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlati3 = ivec4(u_xlat16_3);
    u_xlat16_5.xz = (u_xlati3.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_5.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_4.xyz = (u_xlati3.z != 0) ? u_xlat16_5.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = (u_xlati3.y != 0) ? u_xlat16_4.xyz : u_xlat16_1.xzw;
    u_xlat16_4.xyz = (u_xlati3.x != 0) ? u_xlat16_4.xyz : u_xlat16_1.yzx;
    u_xlat16_1.xyz = (int(u_xlati2) != 0) ? u_xlat16_4.xyz : u_xlat16_1.zwx;
    u_xlat2.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    u_xlat2.xyz = u_xlat2.xyz * _EnvColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_lightProbToggle);
#else
    u_xlatb23 = 0.5<_lightProbToggle;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb23)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_0.w = u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _Blend;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _ClosedMouthTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
ivec4 u_xlati3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_8;
ivec3 u_xlati9;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb16;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedMouthTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz;
        u_xlat16_21 = u_xlat10_0.w;
    } else {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_2.xyz;
        u_xlat16_21 = u_xlat10_2.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_22 = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_4.xy = (int(u_xlati2) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_22 = (-u_xlat16_1.z) + u_xlat16_4.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_5.z = (u_xlati2 != 0) ? u_xlat16_4.y : u_xlat16_1.z;
    u_xlat16_22 = u_xlat16_1.z + (-u_xlat16_4.x);
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_22 = (u_xlati2 != 0) ? u_xlat16_4.x : u_xlat16_1.z;
    u_xlat16_22 = (-u_xlat16_22) + u_xlat16_5.z;
    u_xlat16_4.x = abs(u_xlat16_22) + 0.999000013;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.y = u_xlat16_22 / u_xlat16_5.z;
    u_xlat16_6.xyz = (-u_xlat16_1.yzx) + u_xlat16_5.zzz;
    u_xlat16_18.x = u_xlat16_22 * 6.0;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * vec3(3.0, 3.0, 3.0) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz / u_xlat16_18.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_5.zzz);
    u_xlat16_1.xyz = abs(u_xlat16_1.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_1.xyz = floor(u_xlat16_1.xyz);
    u_xlat16_22 = (-u_xlat16_6.x) + u_xlat16_6.y;
    u_xlat16_18.xy = u_xlat16_6.zx + vec2(0.333333343, 0.666666687);
    u_xlati9.xyz = ivec3(u_xlat16_1.xyz);
    u_xlat16_1.xy = vec2((-u_xlat16_6.y) + u_xlat16_18.x, (-u_xlat16_6.z) + u_xlat16_18.y);
    u_xlat16_8.x = (u_xlati9.z != 0) ? 0.0 : u_xlat16_1.y;
    u_xlat16_1.x = (u_xlati9.y != 0) ? u_xlat16_8.x : u_xlat16_1.x;
    u_xlat16_4.x = (u_xlati9.x != 0) ? u_xlat16_1.x : u_xlat16_22;
    u_xlat16_5.xy = (int(u_xlati2) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_8.xyz = u_xlat16_5.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = ceil(u_xlat16_1.x);
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.yzx + u_xlat16_8.yzx;
    u_xlat16_4.x = u_xlat16_1.w * 6.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_11.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_5.y = u_xlat16_1.y * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_1.w * 6.0 + (-u_xlat16_4.x);
    u_xlat16_11.y = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_11.x = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_11.yx;
    u_xlat16_11.x = abs(u_xlat16_4.x) + 0.999000013;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlati2 = int(u_xlat16_11.x);
    u_xlat16_3 = u_xlat16_4.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_3 = abs(u_xlat16_3) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlati3 = ivec4(u_xlat16_3);
    u_xlat16_5.xz = (u_xlati3.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_5.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_4.xyz = (u_xlati3.z != 0) ? u_xlat16_5.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = (u_xlati3.y != 0) ? u_xlat16_4.xyz : u_xlat16_1.xzw;
    u_xlat16_4.xyz = (u_xlati3.x != 0) ? u_xlat16_4.xyz : u_xlat16_1.yzx;
    u_xlat16_1.xyz = (int(u_xlati2) != 0) ? u_xlat16_4.xyz : u_xlat16_1.zwx;
    u_xlat2.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    u_xlat2.xyz = u_xlat2.xyz * _EnvColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_lightProbToggle);
#else
    u_xlatb23 = 0.5<_lightProbToggle;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb23)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_0.w = u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _Blend;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _ColorTolerance;
uniform 	mediump float _HueOffset;
uniform 	mediump float _SaturateOffset;
uniform 	mediump float _ValueOffset;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _ClosedMouthTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
ivec4 u_xlati3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_8;
ivec3 u_xlati9;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb16;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Blend>=0.5);
#else
    u_xlatb0 = _Blend>=0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_ClosedMouthTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz;
        u_xlat16_21 = u_xlat10_0.w;
    } else {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_2.xyz;
        u_xlat16_21 = u_xlat10_2.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_22 = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_4.xy = (int(u_xlati2) != 0) ? u_xlat16_1.xy : u_xlat16_1.yx;
    u_xlat16_22 = (-u_xlat16_1.z) + u_xlat16_4.y;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_5.z = (u_xlati2 != 0) ? u_xlat16_4.y : u_xlat16_1.z;
    u_xlat16_22 = u_xlat16_1.z + (-u_xlat16_4.x);
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = floor(u_xlat16_22);
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlati2 = int(u_xlat16_22);
    u_xlat16_22 = (u_xlati2 != 0) ? u_xlat16_4.x : u_xlat16_1.z;
    u_xlat16_22 = (-u_xlat16_22) + u_xlat16_5.z;
    u_xlat16_4.x = abs(u_xlat16_22) + 0.999000013;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.y = u_xlat16_22 / u_xlat16_5.z;
    u_xlat16_6.xyz = (-u_xlat16_1.yzx) + u_xlat16_5.zzz;
    u_xlat16_18.x = u_xlat16_22 * 6.0;
    u_xlat16_6.xyz = vec3(u_xlat16_22) * vec3(3.0, 3.0, 3.0) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz / u_xlat16_18.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_5.zzz);
    u_xlat16_1.xyz = abs(u_xlat16_1.xyz) + vec3(0.999000013, 0.999000013, 0.999000013);
    u_xlat16_1.xyz = floor(u_xlat16_1.xyz);
    u_xlat16_22 = (-u_xlat16_6.x) + u_xlat16_6.y;
    u_xlat16_18.xy = u_xlat16_6.zx + vec2(0.333333343, 0.666666687);
    u_xlati9.xyz = ivec3(u_xlat16_1.xyz);
    u_xlat16_1.xy = vec2((-u_xlat16_6.y) + u_xlat16_18.x, (-u_xlat16_6.z) + u_xlat16_18.y);
    u_xlat16_8.x = (u_xlati9.z != 0) ? 0.0 : u_xlat16_1.y;
    u_xlat16_1.x = (u_xlati9.y != 0) ? u_xlat16_8.x : u_xlat16_1.x;
    u_xlat16_4.x = (u_xlati9.x != 0) ? u_xlat16_1.x : u_xlat16_22;
    u_xlat16_5.xy = (int(u_xlati2) != 0) ? u_xlat16_4.xy : vec2(0.0, 0.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz + (-vs_TEXCOORD1.xyz);
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_8.xyz = u_xlat16_5.xyz + vec3(_HueOffset, _SaturateOffset, _ValueOffset);
    u_xlat16_8.x = fract(u_xlat16_8.x);
    u_xlat16_8.yz = u_xlat16_8.yz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.yz = min(max(u_xlat16_8.yz, 0.0), 1.0);
#else
    u_xlat16_8.yz = clamp(u_xlat16_8.yz, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = ceil(u_xlat16_1.x);
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.yzx + u_xlat16_8.yzx;
    u_xlat16_4.x = u_xlat16_1.w * 6.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_11.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_5.y = u_xlat16_1.y * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_1.w * 6.0 + (-u_xlat16_4.x);
    u_xlat16_11.y = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_11.x = (-u_xlat16_1.x) * u_xlat16_11.x + 1.0;
    u_xlat16_1.zw = u_xlat16_1.yy * u_xlat16_11.yx;
    u_xlat16_11.x = abs(u_xlat16_4.x) + 0.999000013;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlati2 = int(u_xlat16_11.x);
    u_xlat16_3 = u_xlat16_4.xxxx + vec4(-1.0, -2.0, -3.0, -4.0);
    u_xlat16_3 = abs(u_xlat16_3) + vec4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlati3 = ivec4(u_xlat16_3);
    u_xlat16_5.xz = (u_xlati3.w != 0) ? u_xlat16_1.yz : u_xlat16_1.wy;
    u_xlat16_1.x = u_xlat16_5.y;
    u_xlat16_1.yzw = u_xlat16_1.zyw;
    u_xlat16_4.xyz = (u_xlati3.z != 0) ? u_xlat16_5.xyz : u_xlat16_1.xyz;
    u_xlat16_4.xyz = (u_xlati3.y != 0) ? u_xlat16_4.xyz : u_xlat16_1.xzw;
    u_xlat16_4.xyz = (u_xlati3.x != 0) ? u_xlat16_4.xyz : u_xlat16_1.yzx;
    u_xlat16_1.xyz = (int(u_xlati2) != 0) ? u_xlat16_4.xyz : u_xlat16_1.zwx;
    u_xlat2.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
    u_xlat2.xyz = u_xlat2.xyz * _EnvColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_lightProbToggle);
#else
    u_xlatb23 = 0.5<_lightProbToggle;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb23)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_0.w = u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
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
  Name "CONSTANT_REPLACE"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 76345
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Fallback "Diffuse"
}