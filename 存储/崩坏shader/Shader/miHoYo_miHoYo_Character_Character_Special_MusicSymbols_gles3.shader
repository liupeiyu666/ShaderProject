//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/MusicSymbols" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Emission ("Emission", Range(1, 10)) = 1
_EmissionColor ("Emmisive Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_UVYScale ("UV Y Scale", Range(0.1, 10)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  ZWrite Off
  Offset -2, -2
  GpuProgramID 8370
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _UVYScale;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb10;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = u_xlat10_0.w + 0.899999976;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati2 = int(u_xlat16_1);
    if((u_xlati2)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD1.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD1.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD1.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(vec3(_Emission, _Emission, _Emission)) * _EmissionColor.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _UVYScale;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb10;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = u_xlat10_0.w + 0.899999976;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati2 = int(u_xlat16_1);
    if((u_xlati2)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD1.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD1.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD1.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(vec3(_Emission, _Emission, _Emission)) * _EmissionColor.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _UVYScale;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb10;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = u_xlat10_0.w + 0.899999976;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati2 = int(u_xlat16_1);
    if((u_xlati2)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD1.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD1.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD1.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(vec3(_Emission, _Emission, _Emission)) * _EmissionColor.xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  ZTest Equal
  ZWrite Off
  GpuProgramID 71243
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _UVYScale;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp float u_xlat10_1;
int u_xlati1;
void main()
{
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_MainTex, u_xlat16_0.xy).w;
    u_xlat16_0.x = u_xlat10_1 + 0.899999976;
    u_xlat16_0.x = floor(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlati1 = int(u_xlat16_0.x);
    if((u_xlati1)==0){discard;}
    SV_Target0 = vec4(_BloomFactor);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _UVYScale;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp float u_xlat10_1;
int u_xlati1;
void main()
{
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_MainTex, u_xlat16_0.xy).w;
    u_xlat16_0.x = u_xlat10_1 + 0.899999976;
    u_xlat16_0.x = floor(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlati1 = int(u_xlat16_0.x);
    if((u_xlati1)==0){discard;}
    SV_Target0 = vec4(_BloomFactor);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _UVYScale;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp float u_xlat10_1;
int u_xlati1;
void main()
{
    u_xlat16_0.x = _UVYScale + 9.99999975e-05;
    u_xlat16_0.y = vs_TEXCOORD0.y / u_xlat16_0.x;
    u_xlat16_0.x = vs_TEXCOORD0.x;
    u_xlat10_1 = texture(_MainTex, u_xlat16_0.xy).w;
    u_xlat16_0.x = u_xlat10_1 + 0.899999976;
    u_xlat16_0.x = floor(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlati1 = int(u_xlat16_0.x);
    if((u_xlati1)==0){discard;}
    SV_Target0 = vec4(_BloomFactor);
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