//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Blind_Texture" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Texture ("Texture", 2D) = "white" { }
[MaterialToggle] _TextureFill ("TextureFill", Float) = 1
_TextureAspectX ("Texture Aspect X", Float) = 1
_TextureAspectY ("Texture Aspect Y", Float) = 1
_Value ("Value", Float) = 0
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  GpuProgramID 39679
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_3.xy = vec2(u_xlat16_3.x * float(_TextureAspectX), u_xlat16_3.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_3.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_3.xy = vec2(u_xlat16_3.x * float(_TextureAspectX), u_xlat16_3.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_3.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_3.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_3.xy = vec2(u_xlat16_3.x * float(_TextureAspectX), u_xlat16_3.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_3.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_4.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_4.xy = vec2(u_xlat16_4.x * float(_TextureAspectX), u_xlat16_4.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_4.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_4.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_4.xy = vec2(u_xlat16_4.x * float(_TextureAspectX), u_xlat16_4.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_4.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Texture_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
    phase0_Output0_1 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureFill;
uniform 	float _TextureAspectX;
uniform 	float _TextureAspectY;
uniform 	float _Value;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Texture;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_TextureFill);
#else
    u_xlatb0 = 0.0<_TextureFill;
#endif
    if(u_xlatb0){
        u_xlat16_1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat10_0.x = texture(_Texture, u_xlat16_1.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    } else {
        u_xlat16_4.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
        u_xlat16_4.xy = vec2(u_xlat16_4.x * float(_TextureAspectX), u_xlat16_4.y * float(_TextureAspectY));
        u_xlat10_0.x = texture(_Texture, u_xlat16_4.xy).y;
        u_xlat16_1.x = u_xlat10_0.x;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Value>=u_xlat16_1.x);
#else
    u_xlatb0 = _Value>=u_xlat16_1.x;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
}
}
}
}