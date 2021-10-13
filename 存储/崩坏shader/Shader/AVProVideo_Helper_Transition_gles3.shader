//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Helper/Transition" {
Properties {
_MainTex ("Texture To", 2D) = "white" { }
_FromTex ("Texture From", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 47713
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_NONE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_NONE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_NONE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat0 = vec4(_Fade) * u_xlat16_0 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat0 = vec4(_Fade) * u_xlat16_0 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat10_1);
    u_xlat0 = vec4(_Fade) * u_xlat16_0 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_BLACK" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-0.0, -0.0, -0.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(0.0, 0.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_BLACK" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-0.0, -0.0, -0.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(0.0, 0.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_BLACK" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-0.0, -0.0, -0.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(0.0, 0.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_WHITE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_WHITE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_WHITE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat16_2 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat16_0 = u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
        u_xlat0 = vec4(u_xlat1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_TRANSP" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat0 = vec4(u_xlat1) * (-u_xlat10_0) + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat0 = u_xlat10_0 * vec4(u_xlat1);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_TRANSP" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat0 = vec4(u_xlat1) * (-u_xlat10_0) + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat0 = u_xlat10_0 * vec4(u_xlat1);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_TRANSP" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade<0.5);
#else
    u_xlatb0 = _Fade<0.5;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_FromTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + _Fade;
        u_xlat0 = vec4(u_xlat1) * (-u_xlat10_0) + u_xlat10_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat1 = _Fade + -0.5;
        u_xlat1 = u_xlat1 + u_xlat1;
        u_xlat0 = u_xlat10_0 * vec4(u_xlat1);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.y);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.y);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=vs_TEXCOORD0.y);
#else
    u_xlatb0 = _Fade>=vs_TEXCOORD0.y;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_VERT_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_VERT_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_VERT_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAG" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAG" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAG" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAG_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAG_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAG_MIRROR" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=abs(u_xlat0.x));
#else
    u_xlatb0 = _Fade>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_CIRCLE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(1.77699995, 1.0) + vec2(-0.888849974, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3 = _Fade * 2.0999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_CIRCLE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(1.77699995, 1.0) + vec2(-0.888849974, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3 = _Fade * 2.0999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_CIRCLE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(1.77699995, 1.0) + vec2(-0.888849974, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3 = _Fade * 2.0999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SCROLL_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat6 = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SCROLL_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat6 = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SCROLL_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat6 = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat6 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat6 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat6 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0>=u_xlat6);
#else
    u_xlatb6 = 0.0>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture(_FromTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = (-u_xlat10_1) + u_xlat10_2;
    u_xlat0 = vec4(u_xlat6) * u_xlat16_2 + u_xlat10_1;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAMOND" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 1.77769995 + -0.888849974;
    u_xlat3 = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat3) + abs(u_xlat0.x);
    u_xlat3 = _Fade * 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAMOND" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 1.77769995 + -0.888849974;
    u_xlat3 = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat3) + abs(u_xlat0.x);
    u_xlat3 = _Fade * 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAMOND" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 1.77769995 + -0.888849974;
    u_xlat3 = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat3) + abs(u_xlat0.x);
    u_xlat3 = _Fade * 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat3>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_BLINDS" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_BLINDS" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_BLINDS" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Fade>=u_xlat0.x);
#else
    u_xlatb0 = _Fade>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_RECTS_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y));
#else
    u_xlatb0 = vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y);
#endif
    u_xlat3 = fract(abs(vs_TEXCOORD0.y));
    u_xlat0.x = (u_xlatb0) ? u_xlat3 : (-u_xlat3);
    u_xlat0.x = u_xlat0.x * 8.0;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _Fade;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat3 = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=abs(u_xlat3));
#else
    u_xlatb0 = u_xlat0.x>=abs(u_xlat3);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_RECTS_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y));
#else
    u_xlatb0 = vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y);
#endif
    u_xlat3 = fract(abs(vs_TEXCOORD0.y));
    u_xlat0.x = (u_xlatb0) ? u_xlat3 : (-u_xlat3);
    u_xlat0.x = u_xlat0.x * 8.0;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _Fade;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat3 = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=abs(u_xlat3));
#else
    u_xlatb0 = u_xlat0.x>=abs(u_xlat3);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_RECTS_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y));
#else
    u_xlatb0 = vs_TEXCOORD0.y>=(-vs_TEXCOORD0.y);
#endif
    u_xlat3 = fract(abs(vs_TEXCOORD0.y));
    u_xlat0.x = (u_xlatb0) ? u_xlat3 : (-u_xlat3);
    u_xlat0.x = u_xlat0.x * 8.0;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _Fade;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat3 = vs_TEXCOORD0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=abs(u_xlat3));
#else
    u_xlatb0 = u_xlat0.x>=abs(u_xlat3);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_ARROW" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat0.x) * 0.5 + _Fade;
    u_xlat3 = vs_TEXCOORD0.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat3);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat3;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_ARROW" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat0.x) * 0.5 + _Fade;
    u_xlat3 = vs_TEXCOORD0.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat3);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat3;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_ARROW" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
float u_xlat3;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y + -0.5;
    u_xlat0.x = abs(u_xlat0.x) * 0.5 + _Fade;
    u_xlat3 = vs_TEXCOORD0.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat3);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat3;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_FromTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.z = (-u_xlat0.x) + vs_TEXCOORD0.x;
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.z = (-u_xlat0.x) + vs_TEXCOORD0.x;
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.z = (-u_xlat0.x) + vs_TEXCOORD0.x;
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.x = vs_TEXCOORD0.x + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SLIDE_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.w = (-u_xlat0.x) + vs_TEXCOORD0.y;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SLIDE_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.w = (-u_xlat0.x) + vs_TEXCOORD0.y;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SLIDE_VERT" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-_Fade) + 1.0;
    u_xlat0.w = (-u_xlat0.x) + vs_TEXCOORD0.y;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat0.y = vs_TEXCOORD0.y + _Fade;
    u_xlat10_2 = texture(_FromTex, u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0>=u_xlat0.x);
#else
    u_xlatb0 = 0.0>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_ZOOM_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = _Fade + -0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = (-_Fade) + 1.0;
    u_xlat3.x = u_xlat3.x * -0.850000024 + 1.0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat3.x = _Fade * -0.850000024 + 1.0;
    u_xlat3.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_2 = texture(_FromTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_ZOOM_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = _Fade + -0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = (-_Fade) + 1.0;
    u_xlat3.x = u_xlat3.x * -0.850000024 + 1.0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat3.x = _Fade * -0.850000024 + 1.0;
    u_xlat3.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_2 = texture(_FromTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_ZOOM_FADE" }
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Fade;
uniform lowp sampler2D _FromTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = _Fade + -0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = (-_Fade) + 1.0;
    u_xlat3.x = u_xlat3.x * -0.850000024 + 1.0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat3.x = _Fade * -0.850000024 + 1.0;
    u_xlat3.xy = u_xlat6.xy * u_xlat3.xx + vec2(0.5, 0.5);
    u_xlat10_2 = texture(_FromTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat16_1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
}
}
}
}