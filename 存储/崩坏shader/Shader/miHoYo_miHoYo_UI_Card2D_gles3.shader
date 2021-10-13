//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Card2D" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_MainMask ("Main Mask", 2D) = "white" { }
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Space(10)] [KeywordEnum(None,Disturb,Motion,Rotation)] _Layer0 ("Layer0 Effect", Float) = 0
_LayerTex0 ("Layer Tex 0", 2D) = "white" { }
_NoiseIntensity0 ("Noise Intensity 0", Range(0, 1)) = 0
_NoiseSpeedX0 ("Noise Speed X 0", Range(-1, 1)) = 0
_NoiseSpeedY0 ("Noise Speed Y 0", Range(-1, 1)) = 0
_ColorTint0 ("Color Tint 0", Color) = (1,1,1,1)
_MotionSpeedX0 ("Motion Speed X 0", Range(-1, 1)) = 0
_MotionSpeedY0 ("Motion Speed Y 0", Range(-1, 1)) = 0
_RotateDegree0 ("Rotate Degree 0", Range(-180, 180)) = 0
_RotateSpeed0 ("Rotate Speed 0", Range(-1, 1)) = 0
_OffsetX0 ("Offset X 0", Range(-1, 1)) = 0
_OffsetY0 ("Offset Y 0", Range(-1, 1)) = 0
_ColorParam0 ("Color Param 0", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose0 ("Compose Method 0", Float) = 0
[Space(10)] [KeywordEnum(None,Motion,Rotation)] _Layer1 ("Layer1 Effect", Float) = 0
_LayerTex1 ("Layer Tex 1", 2D) = "white" { }
_ColorTint1 ("Color Tint 1", Color) = (1,1,1,1)
_MotionSpeedX1 ("Motion Speed X 1", Range(-1, 1)) = 0
_MotionSpeedY1 ("Motion Speed Y 1", Range(-1, 1)) = 0
_RotateDegree1 ("Rotate Degree 1", Range(-180, 180)) = 0
_RotateSpeed1 ("Rotate Speed 1", Range(-1, 1)) = 0
_OffsetX1 ("Offset X 1", Range(-1, 1)) = 0
_OffsetY1 ("Offset Y 1", Range(-1, 1)) = 0
_ColorParam1 ("Color Param 1", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose1 ("Compose Method 1", Float) = 0
[Space(10)] [KeywordEnum(None,Motion,Rotation)] _Layer2 ("Layer2 Effect", Float) = 0
_LayerTex2 ("Layer Tex 2", 2D) = "white" { }
_ColorTint2 ("Color Tint 2", Color) = (1,1,1,1)
_MotionSpeedX2 ("Motion Speed X 2", Range(-1, 1)) = 0
_MotionSpeedY2 ("Motion Speed Y 2", Range(-1, 1)) = 0
_RotateDegree2 ("Rotate Degree 2", Range(-180, 180)) = 0
_RotateSpeed2 ("Rotate Speed 2", Range(-1, 1)) = 0
_OffsetX2 ("Offset X 2", Range(-1, 1)) = 0
_OffsetY2 ("Offset Y 2", Range(-1, 1)) = 0
_ColorParam2 ("Color Param 2", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose2 ("Compose Method 2", Float) = 0
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
  GpuProgramID 14386
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _LayerTex0_ST;
uniform 	vec4 _LayerTex1_ST;
uniform 	vec4 _LayerTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _LayerTex0_ST.xy + _LayerTex0_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LayerTex1_ST.xy + _LayerTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _LayerTex2_ST.xy + _LayerTex2_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump float _NoiseIntensity0;
uniform 	mediump float _NoiseSpeedX0;
uniform 	mediump float _NoiseSpeedY0;
uniform 	mediump vec4 _ColorTint0;
uniform 	mediump float _MotionSpeedX0;
uniform 	mediump float _MotionSpeedY0;
uniform 	mediump float _RotateDegree0;
uniform 	mediump vec4 _ColorParam0;
uniform 	mediump float _RotateSpeed0;
uniform 	mediump float _OffsetX0;
uniform 	mediump float _OffsetY0;
uniform 	mediump vec4 _ColorTint1;
uniform 	mediump float _MotionSpeedX1;
uniform 	mediump float _MotionSpeedY1;
uniform 	mediump float _RotateDegree1;
uniform 	mediump vec4 _ColorParam1;
uniform 	mediump float _RotateSpeed1;
uniform 	mediump float _OffsetX1;
uniform 	mediump float _OffsetY1;
uniform 	mediump vec4 _ColorTint2;
uniform 	mediump float _MotionSpeedX2;
uniform 	mediump float _MotionSpeedY2;
uniform 	mediump float _RotateDegree2;
uniform 	mediump vec4 _ColorParam2;
uniform 	mediump float _RotateSpeed2;
uniform 	mediump float _OffsetX2;
uniform 	mediump float _OffsetY2;
uniform 	mediump float _Layer0;
uniform 	mediump float _Layer1;
uniform 	mediump float _Layer2;
uniform 	mediump float _Compose0;
uniform 	mediump float _Compose1;
uniform 	mediump float _Compose2;
uniform lowp sampler2D _MainMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerTex0;
uniform lowp sampler2D _LayerTex1;
uniform lowp sampler2D _LayerTex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
vec2 u_xlat14;
bvec2 u_xlatb14;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_17;
float u_xlat24;
bool u_xlatb30;
mediump float u_xlat16_36;
void main()
{
    u_xlat10_0.xyz = texture(_MainMask, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(_Layer0==0.0);
#else
    u_xlatb30 = _Layer0==0.0;
#endif
    if(u_xlatb30){
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
        SV_Target0 = u_xlat10_1;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_Layer0==1.0);
#else
        u_xlatb30 = _Layer0==1.0;
#endif
        if(u_xlatb30){
            u_xlat3.xy = _Time.yy * vec2(_NoiseSpeedX0, _NoiseSpeedY0) + vs_TEXCOORD1.xy;
            u_xlat10_4.xy = texture(_LayerTex0, u_xlat3.xy).xy;
            u_xlat16_5.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
            u_xlat16_2.xy = u_xlat16_5.xy * vec2(_NoiseIntensity0);
            u_xlat16_1.x = float(0.0);
            u_xlat16_1.y = float(0.0);
            u_xlat16_1.z = float(0.0);
            u_xlat16_1.w = float(0.0);
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_Layer0==2.0);
#else
            u_xlatb30 = _Layer0==2.0;
#endif
            if(u_xlatb30){
                u_xlat4.x = _RotateDegree0 * 57.2957802;
                u_xlat16_5.x = sin(u_xlat4.x);
                u_xlat16_6.x = cos(u_xlat4.x);
                u_xlat16_7.x = (-u_xlat16_5.x);
                u_xlat16_15.xy = vec2(vs_TEXCOORD1.x + float(-0.5), vs_TEXCOORD1.y + float(-0.5));
                u_xlat16_7.y = u_xlat16_6.x;
                u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                u_xlat16_7.z = u_xlat16_5.x;
                u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX0, _MotionSpeedY0) + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(_Layer0==3.0);
#else
                u_xlatb4 = _Layer0==3.0;
#endif
                if(u_xlatb4){
                    u_xlat4.xy = vec2(vs_TEXCOORD1.x + float(_OffsetX0), vs_TEXCOORD1.y + float(_OffsetY0));
                    u_xlat24 = _Time.y * _RotateSpeed0;
                    u_xlat24 = u_xlat24 * 57.2957802;
                    u_xlat16_5.x = sin(u_xlat24);
                    u_xlat16_6.x = cos(u_xlat24);
                    u_xlat16_7.x = (-u_xlat16_5.x);
                    u_xlat16_15.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                    u_xlat16_7.y = u_xlat16_6.x;
                    u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                    u_xlat16_7.z = u_xlat16_5.x;
                    u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                    u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                    u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                    u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                    u_xlat16_1 = u_xlat16_1;
                } else {
                    u_xlat16_1.x = float(0.0);
                    u_xlat16_1.y = float(0.0);
                    u_xlat16_1.z = float(0.0);
                    u_xlat16_1.w = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam0.z + _ColorParam0.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam0.y * u_xlat4.x + _ColorParam0.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlat14.xy = u_xlat16_2.xy * u_xlat10_0.xx + vs_TEXCOORD0.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat14.xy);
    u_xlatb14.xy = equal(vec4(_Compose0, _Layer1, _Compose0, _Compose0), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat10_5.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(u_xlat16_36);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_7.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_6.xyz : u_xlat16_7.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer1==1.0);
#else
        u_xlatb4 = _Layer1==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree1 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vs_TEXCOORD2.xy + vec2(-0.5, -0.5);
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX1, _MotionSpeedY1) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint1;
            u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer1==2.0);
#else
            u_xlatb4 = _Layer1==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD2.x + float(_OffsetX1), vs_TEXCOORD2.y + float(_OffsetY1));
                u_xlat24 = _Time.y * _RotateSpeed1;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint1;
                u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam1.z + _ColorParam1.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam1.y * u_xlat4.x + _ColorParam1.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlatb14.xy = equal(vec4(_Compose1, _Layer2, _Compose1, _Compose1), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer2==1.0);
#else
        u_xlatb4 = _Layer2==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree2 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vec2(vs_TEXCOORD3.x + float(-0.5), vs_TEXCOORD3.y + float(-0.5));
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX2, _MotionSpeedY2) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex2, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint2;
            u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer2==2.0);
#else
            u_xlatb4 = _Layer2==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD3.x + float(_OffsetX2), vs_TEXCOORD3.y + float(_OffsetY2));
                u_xlat24 = _Time.y * _RotateSpeed2;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_2 = texture(_LayerTex2, u_xlat16_7.xy);
                u_xlat16_2 = u_xlat10_2 * _ColorTint2;
                u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_2;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam2.z + _ColorParam2.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam2.y * u_xlat4.x + _ColorParam2.x;
    u_xlat0 = u_xlat16_1 * u_xlat4.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(_Compose2==0.0);
#else
    u_xlatb14.x = _Compose2==0.0;
#endif
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat0.www + u_xlat16_6.xyz;
    SV_Target0.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    SV_Target0.w = u_xlat10_5.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _LayerTex0_ST;
uniform 	vec4 _LayerTex1_ST;
uniform 	vec4 _LayerTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _LayerTex0_ST.xy + _LayerTex0_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LayerTex1_ST.xy + _LayerTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _LayerTex2_ST.xy + _LayerTex2_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump float _NoiseIntensity0;
uniform 	mediump float _NoiseSpeedX0;
uniform 	mediump float _NoiseSpeedY0;
uniform 	mediump vec4 _ColorTint0;
uniform 	mediump float _MotionSpeedX0;
uniform 	mediump float _MotionSpeedY0;
uniform 	mediump float _RotateDegree0;
uniform 	mediump vec4 _ColorParam0;
uniform 	mediump float _RotateSpeed0;
uniform 	mediump float _OffsetX0;
uniform 	mediump float _OffsetY0;
uniform 	mediump vec4 _ColorTint1;
uniform 	mediump float _MotionSpeedX1;
uniform 	mediump float _MotionSpeedY1;
uniform 	mediump float _RotateDegree1;
uniform 	mediump vec4 _ColorParam1;
uniform 	mediump float _RotateSpeed1;
uniform 	mediump float _OffsetX1;
uniform 	mediump float _OffsetY1;
uniform 	mediump vec4 _ColorTint2;
uniform 	mediump float _MotionSpeedX2;
uniform 	mediump float _MotionSpeedY2;
uniform 	mediump float _RotateDegree2;
uniform 	mediump vec4 _ColorParam2;
uniform 	mediump float _RotateSpeed2;
uniform 	mediump float _OffsetX2;
uniform 	mediump float _OffsetY2;
uniform 	mediump float _Layer0;
uniform 	mediump float _Layer1;
uniform 	mediump float _Layer2;
uniform 	mediump float _Compose0;
uniform 	mediump float _Compose1;
uniform 	mediump float _Compose2;
uniform lowp sampler2D _MainMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerTex0;
uniform lowp sampler2D _LayerTex1;
uniform lowp sampler2D _LayerTex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
vec2 u_xlat14;
bvec2 u_xlatb14;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_17;
float u_xlat24;
bool u_xlatb30;
mediump float u_xlat16_36;
void main()
{
    u_xlat10_0.xyz = texture(_MainMask, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(_Layer0==0.0);
#else
    u_xlatb30 = _Layer0==0.0;
#endif
    if(u_xlatb30){
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
        SV_Target0 = u_xlat10_1;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_Layer0==1.0);
#else
        u_xlatb30 = _Layer0==1.0;
#endif
        if(u_xlatb30){
            u_xlat3.xy = _Time.yy * vec2(_NoiseSpeedX0, _NoiseSpeedY0) + vs_TEXCOORD1.xy;
            u_xlat10_4.xy = texture(_LayerTex0, u_xlat3.xy).xy;
            u_xlat16_5.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
            u_xlat16_2.xy = u_xlat16_5.xy * vec2(_NoiseIntensity0);
            u_xlat16_1.x = float(0.0);
            u_xlat16_1.y = float(0.0);
            u_xlat16_1.z = float(0.0);
            u_xlat16_1.w = float(0.0);
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_Layer0==2.0);
#else
            u_xlatb30 = _Layer0==2.0;
#endif
            if(u_xlatb30){
                u_xlat4.x = _RotateDegree0 * 57.2957802;
                u_xlat16_5.x = sin(u_xlat4.x);
                u_xlat16_6.x = cos(u_xlat4.x);
                u_xlat16_7.x = (-u_xlat16_5.x);
                u_xlat16_15.xy = vec2(vs_TEXCOORD1.x + float(-0.5), vs_TEXCOORD1.y + float(-0.5));
                u_xlat16_7.y = u_xlat16_6.x;
                u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                u_xlat16_7.z = u_xlat16_5.x;
                u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX0, _MotionSpeedY0) + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(_Layer0==3.0);
#else
                u_xlatb4 = _Layer0==3.0;
#endif
                if(u_xlatb4){
                    u_xlat4.xy = vec2(vs_TEXCOORD1.x + float(_OffsetX0), vs_TEXCOORD1.y + float(_OffsetY0));
                    u_xlat24 = _Time.y * _RotateSpeed0;
                    u_xlat24 = u_xlat24 * 57.2957802;
                    u_xlat16_5.x = sin(u_xlat24);
                    u_xlat16_6.x = cos(u_xlat24);
                    u_xlat16_7.x = (-u_xlat16_5.x);
                    u_xlat16_15.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                    u_xlat16_7.y = u_xlat16_6.x;
                    u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                    u_xlat16_7.z = u_xlat16_5.x;
                    u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                    u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                    u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                    u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                    u_xlat16_1 = u_xlat16_1;
                } else {
                    u_xlat16_1.x = float(0.0);
                    u_xlat16_1.y = float(0.0);
                    u_xlat16_1.z = float(0.0);
                    u_xlat16_1.w = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam0.z + _ColorParam0.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam0.y * u_xlat4.x + _ColorParam0.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlat14.xy = u_xlat16_2.xy * u_xlat10_0.xx + vs_TEXCOORD0.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat14.xy);
    u_xlatb14.xy = equal(vec4(_Compose0, _Layer1, _Compose0, _Compose0), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat10_5.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(u_xlat16_36);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_7.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_6.xyz : u_xlat16_7.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer1==1.0);
#else
        u_xlatb4 = _Layer1==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree1 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vs_TEXCOORD2.xy + vec2(-0.5, -0.5);
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX1, _MotionSpeedY1) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint1;
            u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer1==2.0);
#else
            u_xlatb4 = _Layer1==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD2.x + float(_OffsetX1), vs_TEXCOORD2.y + float(_OffsetY1));
                u_xlat24 = _Time.y * _RotateSpeed1;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint1;
                u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam1.z + _ColorParam1.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam1.y * u_xlat4.x + _ColorParam1.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlatb14.xy = equal(vec4(_Compose1, _Layer2, _Compose1, _Compose1), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer2==1.0);
#else
        u_xlatb4 = _Layer2==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree2 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vec2(vs_TEXCOORD3.x + float(-0.5), vs_TEXCOORD3.y + float(-0.5));
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX2, _MotionSpeedY2) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex2, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint2;
            u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer2==2.0);
#else
            u_xlatb4 = _Layer2==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD3.x + float(_OffsetX2), vs_TEXCOORD3.y + float(_OffsetY2));
                u_xlat24 = _Time.y * _RotateSpeed2;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_2 = texture(_LayerTex2, u_xlat16_7.xy);
                u_xlat16_2 = u_xlat10_2 * _ColorTint2;
                u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_2;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam2.z + _ColorParam2.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam2.y * u_xlat4.x + _ColorParam2.x;
    u_xlat0 = u_xlat16_1 * u_xlat4.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(_Compose2==0.0);
#else
    u_xlatb14.x = _Compose2==0.0;
#endif
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat0.www + u_xlat16_6.xyz;
    SV_Target0.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    SV_Target0.w = u_xlat10_5.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _LayerTex0_ST;
uniform 	vec4 _LayerTex1_ST;
uniform 	vec4 _LayerTex2_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _LayerTex0_ST.xy + _LayerTex0_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LayerTex1_ST.xy + _LayerTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _LayerTex2_ST.xy + _LayerTex2_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump float _NoiseIntensity0;
uniform 	mediump float _NoiseSpeedX0;
uniform 	mediump float _NoiseSpeedY0;
uniform 	mediump vec4 _ColorTint0;
uniform 	mediump float _MotionSpeedX0;
uniform 	mediump float _MotionSpeedY0;
uniform 	mediump float _RotateDegree0;
uniform 	mediump vec4 _ColorParam0;
uniform 	mediump float _RotateSpeed0;
uniform 	mediump float _OffsetX0;
uniform 	mediump float _OffsetY0;
uniform 	mediump vec4 _ColorTint1;
uniform 	mediump float _MotionSpeedX1;
uniform 	mediump float _MotionSpeedY1;
uniform 	mediump float _RotateDegree1;
uniform 	mediump vec4 _ColorParam1;
uniform 	mediump float _RotateSpeed1;
uniform 	mediump float _OffsetX1;
uniform 	mediump float _OffsetY1;
uniform 	mediump vec4 _ColorTint2;
uniform 	mediump float _MotionSpeedX2;
uniform 	mediump float _MotionSpeedY2;
uniform 	mediump float _RotateDegree2;
uniform 	mediump vec4 _ColorParam2;
uniform 	mediump float _RotateSpeed2;
uniform 	mediump float _OffsetX2;
uniform 	mediump float _OffsetY2;
uniform 	mediump float _Layer0;
uniform 	mediump float _Layer1;
uniform 	mediump float _Layer2;
uniform 	mediump float _Compose0;
uniform 	mediump float _Compose1;
uniform 	mediump float _Compose2;
uniform lowp sampler2D _MainMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerTex0;
uniform lowp sampler2D _LayerTex1;
uniform lowp sampler2D _LayerTex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
vec2 u_xlat14;
bvec2 u_xlatb14;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_17;
float u_xlat24;
bool u_xlatb30;
mediump float u_xlat16_36;
void main()
{
    u_xlat10_0.xyz = texture(_MainMask, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(_Layer0==0.0);
#else
    u_xlatb30 = _Layer0==0.0;
#endif
    if(u_xlatb30){
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
        SV_Target0 = u_xlat10_1;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_Layer0==1.0);
#else
        u_xlatb30 = _Layer0==1.0;
#endif
        if(u_xlatb30){
            u_xlat3.xy = _Time.yy * vec2(_NoiseSpeedX0, _NoiseSpeedY0) + vs_TEXCOORD1.xy;
            u_xlat10_4.xy = texture(_LayerTex0, u_xlat3.xy).xy;
            u_xlat16_5.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
            u_xlat16_2.xy = u_xlat16_5.xy * vec2(_NoiseIntensity0);
            u_xlat16_1.x = float(0.0);
            u_xlat16_1.y = float(0.0);
            u_xlat16_1.z = float(0.0);
            u_xlat16_1.w = float(0.0);
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_Layer0==2.0);
#else
            u_xlatb30 = _Layer0==2.0;
#endif
            if(u_xlatb30){
                u_xlat4.x = _RotateDegree0 * 57.2957802;
                u_xlat16_5.x = sin(u_xlat4.x);
                u_xlat16_6.x = cos(u_xlat4.x);
                u_xlat16_7.x = (-u_xlat16_5.x);
                u_xlat16_15.xy = vec2(vs_TEXCOORD1.x + float(-0.5), vs_TEXCOORD1.y + float(-0.5));
                u_xlat16_7.y = u_xlat16_6.x;
                u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                u_xlat16_7.z = u_xlat16_5.x;
                u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX0, _MotionSpeedY0) + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(_Layer0==3.0);
#else
                u_xlatb4 = _Layer0==3.0;
#endif
                if(u_xlatb4){
                    u_xlat4.xy = vec2(vs_TEXCOORD1.x + float(_OffsetX0), vs_TEXCOORD1.y + float(_OffsetY0));
                    u_xlat24 = _Time.y * _RotateSpeed0;
                    u_xlat24 = u_xlat24 * 57.2957802;
                    u_xlat16_5.x = sin(u_xlat24);
                    u_xlat16_6.x = cos(u_xlat24);
                    u_xlat16_7.x = (-u_xlat16_5.x);
                    u_xlat16_15.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                    u_xlat16_7.y = u_xlat16_6.x;
                    u_xlat4.x = dot(u_xlat16_7.yx, u_xlat16_15.xy);
                    u_xlat16_7.z = u_xlat16_5.x;
                    u_xlat4.y = dot(u_xlat16_7.zy, u_xlat16_15.xy);
                    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                    u_xlat10_3 = texture(_LayerTex0, u_xlat4.xy);
                    u_xlat16_3 = u_xlat10_3 * _ColorTint0;
                    u_xlat16_1 = u_xlat10_0.xxxx * u_xlat16_3;
                    u_xlat16_1 = u_xlat16_1;
                } else {
                    u_xlat16_1.x = float(0.0);
                    u_xlat16_1.y = float(0.0);
                    u_xlat16_1.z = float(0.0);
                    u_xlat16_1.w = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam0.z + _ColorParam0.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam0.y * u_xlat4.x + _ColorParam0.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlat14.xy = u_xlat16_2.xy * u_xlat10_0.xx + vs_TEXCOORD0.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat14.xy);
    u_xlatb14.xy = equal(vec4(_Compose0, _Layer1, _Compose0, _Compose0), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat10_5.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_5.xyz * vec3(u_xlat16_36);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_7.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_6.xyz : u_xlat16_7.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer1==1.0);
#else
        u_xlatb4 = _Layer1==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree1 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vs_TEXCOORD2.xy + vec2(-0.5, -0.5);
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX1, _MotionSpeedY1) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint1;
            u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer1==2.0);
#else
            u_xlatb4 = _Layer1==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD2.x + float(_OffsetX1), vs_TEXCOORD2.y + float(_OffsetY1));
                u_xlat24 = _Time.y * _RotateSpeed1;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_3 = texture(_LayerTex1, u_xlat16_7.xy);
                u_xlat16_3 = u_xlat10_3 * _ColorTint1;
                u_xlat16_1 = u_xlat10_0.yyyy * u_xlat16_3;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam1.z + _ColorParam1.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam1.y * u_xlat4.x + _ColorParam1.x;
    u_xlat3 = u_xlat16_1 * u_xlat4.xxxx;
    u_xlatb14.xy = equal(vec4(_Compose1, _Layer2, _Compose1, _Compose1), vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * u_xlat3.www + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    if(u_xlatb14.y){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat10_5.w;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_Layer2==1.0);
#else
        u_xlatb4 = _Layer2==1.0;
#endif
        if(u_xlatb4){
            u_xlat4.x = _RotateDegree2 * 57.2957802;
            u_xlat16_7.x = sin(u_xlat4.x);
            u_xlat16_8 = cos(u_xlat4.x);
            u_xlat16_9.x = (-u_xlat16_7.x);
            u_xlat16_17.xy = vec2(vs_TEXCOORD3.x + float(-0.5), vs_TEXCOORD3.y + float(-0.5));
            u_xlat16_9.y = u_xlat16_8;
            u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
            u_xlat16_9.z = u_xlat16_7.x;
            u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xy = _Time.yy * vec2(_MotionSpeedX2, _MotionSpeedY2) + u_xlat4.xy;
            u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
            u_xlat10_3 = texture(_LayerTex2, u_xlat16_7.xy);
            u_xlat16_3 = u_xlat10_3 * _ColorTint2;
            u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_3;
            u_xlat16_1 = u_xlat16_1;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_Layer2==2.0);
#else
            u_xlatb4 = _Layer2==2.0;
#endif
            if(u_xlatb4){
                u_xlat4.xy = vec2(vs_TEXCOORD3.x + float(_OffsetX2), vs_TEXCOORD3.y + float(_OffsetY2));
                u_xlat24 = _Time.y * _RotateSpeed2;
                u_xlat24 = u_xlat24 * 57.2957802;
                u_xlat16_7.x = sin(u_xlat24);
                u_xlat16_8 = cos(u_xlat24);
                u_xlat16_9.x = (-u_xlat16_7.x);
                u_xlat16_17.xy = u_xlat4.xy + vec2(-0.5, -0.5);
                u_xlat16_9.y = u_xlat16_8;
                u_xlat4.x = dot(u_xlat16_9.yx, u_xlat16_17.xy);
                u_xlat16_9.z = u_xlat16_7.x;
                u_xlat4.y = dot(u_xlat16_9.zy, u_xlat16_17.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat16_7.xy = u_xlat16_2.xy + u_xlat4.xy;
                u_xlat10_2 = texture(_LayerTex2, u_xlat16_7.xy);
                u_xlat16_2 = u_xlat10_2 * _ColorTint2;
                u_xlat16_1 = u_xlat10_0.zzzz * u_xlat16_2;
                u_xlat16_1 = u_xlat16_1;
            } else {
                u_xlat16_1.x = float(0.0);
                u_xlat16_1.y = float(0.0);
                u_xlat16_1.z = float(0.0);
                u_xlat16_1.w = float(0.0);
            //ENDIF
            }
        //ENDIF
        }
    //ENDIF
    }
    u_xlat4.x = _Time.y * _ColorParam2.z + _ColorParam2.w;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = _ColorParam2.y * u_xlat4.x + _ColorParam2.x;
    u_xlat0 = u_xlat16_1 * u_xlat4.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14.x = !!(_Compose2==0.0);
#else
    u_xlatb14.x = _Compose2==0.0;
#endif
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat4.xxx + u_xlat16_6.xyz;
    u_xlat16_36 = (-u_xlat16_1.w) * u_xlat4.x + 1.0;
    u_xlat16_6.xyz = vec3(u_xlat16_36) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat0.www + u_xlat16_6.xyz;
    SV_Target0.xyz = (u_xlatb14.x) ? u_xlat16_7.xyz : u_xlat16_6.xyz;
    SV_Target0.w = u_xlat10_5.w;
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
}
CustomEditor "MoleMole.Card2DEffectEditor"
}