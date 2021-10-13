//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/Alpha Blended_AddEdge" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_EdgeTex ("EdgeTex", 2D) = "white" { }
_EdgeColor ("EdgeColor", Color) = (1,1,1,1)
_EdgeFactor ("EdgeFactor", Range(0, 100)) = 1
_AppearTime ("Appear Time", Range(0, 1)) = 0
_VanishTime ("Vanish Time", Range(0, 1)) = 0
_AlphaOverLife ("Alpha Over Life", Vector) = (0.197,0.815,0,0)
_CamForward ("Camera Forward", Vector) = (0,0,1,0)
_IsUseCamForward ("Is Use Camera Forward", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 6241
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform 	float _EdgeFactor;
uniform 	mediump vec4 _EdgeColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EdgeTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + 0.999000013;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat0.x = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat10_1.xyz = texture(_EdgeTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_EdgeFactor);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform 	float _EdgeFactor;
uniform 	mediump vec4 _EdgeColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EdgeTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + 0.999000013;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat0.x = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat10_1.xyz = texture(_EdgeTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_EdgeFactor);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform 	float _EdgeFactor;
uniform 	mediump vec4 _EdgeColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EdgeTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + 0.999000013;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat0.x = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat10_1.xyz = texture(_EdgeTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_EdgeFactor);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
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
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 104545
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
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
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
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
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
uint u_xlatu4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
float u_xlat7;
uint u_xlatu7;
bool u_xlatb7;
float u_xlat9;
int u_xlati9;
uint u_xlatu9;
float u_xlat10;
void main()
{
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat0.x = u_xlat0.x + (-in_TEXCOORD0.x);
    u_xlat3 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat3 * 14.9899998;
    u_xlat6 = floor(u_xlat6);
    u_xlatu9 = uint(int(u_xlat6));
    u_xlatu1 = u_xlatu9 + 1u;
    u_xlatu4 = u_xlatu9 >> 2u;
    u_xlati9 = int(u_xlatu9 & 3u);
    u_xlatu7 = u_xlatu1 >> 2u;
    u_xlati1 = int(u_xlatu1 & 3u);
    u_xlat6 = u_xlat3 * 14.9899998 + (-u_xlat6);
    if(u_xlatu4 == uint(0u)) {
        if(u_xlatu7 == uint(0u)) {
            u_xlat10 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].x;
            u_xlat10 = u_xlat6 * u_xlat10 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        } else {
            u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].x) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
            u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].x;
        //ENDIF
        }
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(int(u_xlatu4)==1);
#else
        u_xlatb2 = int(u_xlatu4)==1;
#endif
        if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu7)==1);
#else
            u_xlatb2 = int(u_xlatu7)==1;
#endif
            if(u_xlatb2){
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].y;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            } else {
                u_xlat2.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].y) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                u_xlat10 = u_xlat6 * u_xlat2.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].y;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb2 = !!(int(u_xlatu4)==2);
#else
            u_xlatb2 = int(u_xlatu4)==2;
#endif
            if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
                u_xlatb7 = !!(int(u_xlatu7)==2);
#else
                u_xlatb7 = int(u_xlatu7)==2;
#endif
                if(u_xlatb7){
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].z;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                } else {
                    u_xlat7 = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].z) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat7 + hlslcc_mtx4x4_SizeOverLife[u_xlati9].z;
                //ENDIF
                }
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(int(u_xlatu4)==3);
#else
                u_xlatb4 = int(u_xlatu4)==3;
#endif
                if(u_xlatb4){
                    u_xlat1.x = (-hlslcc_mtx4x4_SizeOverLife[u_xlati9].w) + hlslcc_mtx4x4_SizeOverLife[u_xlati1].w;
                    u_xlat10 = u_xlat6 * u_xlat1.x + hlslcc_mtx4x4_SizeOverLife[u_xlati9].w;
                } else {
                    u_xlat10 = 0.0;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat1.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat1.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat1.xyz);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat10) + in_POSITION0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat6 = u_xlat3 + (-_AlphaOverLife.xxxy.z);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat9 = u_xlat3 / _AlphaOverLife.xxxy.z;
    u_xlat6 = (u_xlati6 != 0) ? 1.0 : u_xlat9;
    u_xlat9 = (-u_xlat3) + _AlphaOverLife.xxxy.w;
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat1.x = (-_AlphaOverLife.xxxy.w) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat1.x;
    u_xlat3 = (u_xlati9 != 0) ? u_xlat6 : u_xlat3;
    u_xlat6 = max(_VanishTime, 0.0);
    u_xlat9 = (-u_xlat6) + in_TEXCOORD0.x;
    u_xlat6 = (-u_xlat6) + _AppearTime;
    u_xlat1.x = u_xlat9 / u_xlat6;
    u_xlat1.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_COLOR0.w = u_xlat3;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
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
CustomEditor "MoleMole.TrailShaderEditorBase"
}