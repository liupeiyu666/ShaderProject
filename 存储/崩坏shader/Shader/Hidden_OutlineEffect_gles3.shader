//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/OutlineEffect" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 3776
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
bvec3 u_xlatb0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
vec2 u_xlat10;
int u_xlati12;
void main()
{
    u_xlat0.x = _LineThicknessX;
    u_xlat0.y = float(0.0);
    u_xlat8.y = float(0.0);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat1.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat8.x = (-_LineThicknessX);
    u_xlat0.xy = u_xlat8.xy + vs_TEXCOORD0.xy;
    u_xlat0.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat2.x = float(0.0);
    u_xlat10.x = float(0.0);
    u_xlat2.y = _LineThicknessY;
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat10.y = (-_LineThicknessY);
    u_xlat2.xy = u_xlat10.xy + vs_TEXCOORD0.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat1.xyzx).xyz;
    u_xlatb0.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat0.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlatb0.xyz) * 0xffffffffu | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat3.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat2.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlati12 = int(uint(u_xlati0.z) & uint(u_xlati0.x));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati0.z));
    u_xlati0.x = int(uint(u_xlati0.x) & uint(u_xlati0.y));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati12));
    if(u_xlati0.x != 0) {
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    } else {
        u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_0 = texture(_OutlineSource, u_xlat0.xy);
        SV_Target0 = u_xlat10_0;
        return;
    //ENDIF
    }
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
bvec3 u_xlatb0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
vec2 u_xlat10;
int u_xlati12;
void main()
{
    u_xlat0.x = _LineThicknessX;
    u_xlat0.y = float(0.0);
    u_xlat8.y = float(0.0);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat1.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat8.x = (-_LineThicknessX);
    u_xlat0.xy = u_xlat8.xy + vs_TEXCOORD0.xy;
    u_xlat0.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat2.x = float(0.0);
    u_xlat10.x = float(0.0);
    u_xlat2.y = _LineThicknessY;
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat10.y = (-_LineThicknessY);
    u_xlat2.xy = u_xlat10.xy + vs_TEXCOORD0.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat1.xyzx).xyz;
    u_xlatb0.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat0.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlatb0.xyz) * 0xffffffffu | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat3.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat2.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlati12 = int(uint(u_xlati0.z) & uint(u_xlati0.x));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati0.z));
    u_xlati0.x = int(uint(u_xlati0.x) & uint(u_xlati0.y));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati12));
    if(u_xlati0.x != 0) {
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    } else {
        u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_0 = texture(_OutlineSource, u_xlat0.xy);
        SV_Target0 = u_xlat10_0;
        return;
    //ENDIF
    }
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
ivec3 u_xlati0;
bvec3 u_xlatb0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat8;
vec2 u_xlat10;
int u_xlati12;
void main()
{
    u_xlat0.x = _LineThicknessX;
    u_xlat0.y = float(0.0);
    u_xlat8.y = float(0.0);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat1.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat8.x = (-_LineThicknessX);
    u_xlat0.xy = u_xlat8.xy + vs_TEXCOORD0.xy;
    u_xlat0.xyz = texture(_OutlineSource, u_xlat0.xy).xyz;
    u_xlat2.x = float(0.0);
    u_xlat10.x = float(0.0);
    u_xlat2.y = _LineThicknessY;
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat10.y = (-_LineThicknessY);
    u_xlat2.xy = u_xlat10.xy + vs_TEXCOORD0.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat1.xyzx).xyz;
    u_xlatb0.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat0.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlatb0.xyz) * 0xffffffffu | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat3.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlatb1.xyz = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.0), u_xlat2.xyzx).xyz;
    u_xlati0.xyz = ivec3(uvec3(u_xlati0.xyz) | uvec3(u_xlatb1.xyz) * 0xffffffffu);
    u_xlati12 = int(uint(u_xlati0.z) & uint(u_xlati0.x));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati0.z));
    u_xlati0.x = int(uint(u_xlati0.x) & uint(u_xlati0.y));
    u_xlati0.x = int(uint(u_xlati0.x) | uint(u_xlati12));
    if(u_xlati0.x != 0) {
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    } else {
        u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_0 = texture(_OutlineSource, u_xlat0.xy);
        SV_Target0 = u_xlat10_0;
        return;
    //ENDIF
    }
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
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 80399
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform 	float _LineIntensity;
uniform 	mediump vec4 _LineColor1;
uniform 	mediump vec4 _LineColor2;
uniform 	mediump vec4 _LineColor3;
uniform 	int _FlipY;
uniform 	int _Dark;
uniform 	float _FillAmount;
uniform 	int _CornerOutlines;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
ivec4 u_xlati6;
bvec4 u_xlatb6;
vec4 u_xlat7;
mediump vec4 u_xlat16_7;
bvec4 u_xlatb7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec4 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
bvec2 u_xlatb15;
bvec2 u_xlatb19;
vec2 u_xlat26;
bool u_xlatb26;
vec2 u_xlat28;
bvec2 u_xlatb28;
vec2 u_xlat30;
bvec2 u_xlatb32;
bool u_xlatb39;
bool u_xlatb41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_FlipY==1);
#else
    u_xlatb0 = _FlipY==1;
#endif
    u_xlat13 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat13 : vs_TEXCOORD0.y;
    u_xlat26.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat26.xy);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat26.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat26.x = texture(_OutlineSource, u_xlat26.xy).w;
    u_xlat2.x = _LineThicknessX;
    u_xlat2.y = float(0.0);
    u_xlat28.y = float(0.0);
    u_xlat2.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat28.x = (-_LineThicknessX);
    u_xlat2.xy = u_xlat0.xy + u_xlat28.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat4.x = float(0.0);
    u_xlat30.x = float(0.0);
    u_xlat4.y = _LineThicknessY;
    u_xlat4.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat5.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
    u_xlat30.y = (-_LineThicknessY);
    u_xlat4.xy = u_xlat0.xy + u_xlat30.xy;
    u_xlat4.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat26.x<0.949999988);
#else
    u_xlatb26 = u_xlat26.x<0.949999988;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(_Dark!=0);
#else
    u_xlatb39 = _Dark!=0;
#endif
    u_xlatb39 = u_xlatb39 && u_xlatb26;
    if(_CornerOutlines != 0) {
        u_xlat6.xy = u_xlat0.xy + vec2(_LineThicknessX, _LineThicknessY);
        u_xlat6.xyz = texture(_OutlineSource, u_xlat6.xy).xyz;
        u_xlat7.xy = u_xlat0.xy + (-vec2(_LineThicknessX, _LineThicknessY));
        u_xlat7.xyz = texture(_OutlineSource, u_xlat7.xy).xyz;
        u_xlat8 = vec4(_LineThicknessX, _LineThicknessY, _LineThicknessX, _LineThicknessY) * vec4(1.0, -1.0, -1.0, 1.0) + u_xlat0.xyxy;
        u_xlat9.xyz = texture(_OutlineSource, u_xlat8.xy).xyz;
        u_xlat8.xyz = texture(_OutlineSource, u_xlat8.zw).xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb0 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb13 = 0.949999988<u_xlat2.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb13 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb13 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat6.x);
#else
        u_xlatb13 = 0.949999988<u_xlat6.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat7.x);
#else
        u_xlatb13 = 0.949999988<u_xlat7.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat9.x);
#else
        u_xlatb13 = 0.949999988<u_xlat9.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat8.x);
#else
        u_xlatb13 = 0.949999988<u_xlat8.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
        if(u_xlatb0){
            u_xlat10 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat10 = u_xlat10 * _LineColor1.wwww;
            u_xlat16_11.x = (-_LineColor1.w) + 1.0;
            u_xlat16_11 = u_xlat1 * u_xlat16_11.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_11 : u_xlat1;
            u_xlat16_10 = u_xlat10;
            u_xlati0 = -1;
        } else {
            u_xlatb6.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat2.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlatb6.xw) * 0xffffffffu | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat5.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat4.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb19.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat6.yzyy).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb19.xy) * 0xffffffffu | uvec2(u_xlati6.xw));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat7.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat9.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat8.yzyz).xy;
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat7 = u_xlat7 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlat9 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat9 = u_xlat9 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_12 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_12 = (bool(u_xlatb39)) ? u_xlat16_12 : u_xlat1;
            u_xlat16_12 = (u_xlati6.y != 0) ? u_xlat16_12 : u_xlat1;
            u_xlat16_9 = (u_xlati6.y != 0) ? u_xlat9 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati6.x != 0) ? u_xlat16_8 : u_xlat16_12;
            u_xlat16_10 = (u_xlati6.x != 0) ? u_xlat7 : u_xlat16_9;
            u_xlati0 = int(uint(u_xlati6.y) | uint(u_xlati6.x));
        //ENDIF
        }
        u_xlat6 = u_xlat16_10 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_10 : u_xlat6;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb41 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb2.x = 0.949999988<u_xlat2.x;
#endif
        u_xlatb2.x = u_xlatb2.x || u_xlatb41;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb41 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb41 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
        if(u_xlatb2.x){
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat7 = u_xlat7 * _LineColor1.wwww;
            u_xlat16_12.x = (-_LineColor1.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_7 = u_xlat7;
            u_xlati0 = -1;
        } else {
            u_xlatb2.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb15.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat2.yzyy).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb15.xy) * 0xffffffffu | uvec2(u_xlatb2.xw) * 0xffffffffu);
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat5.yzyz).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat4.yzyz).xy;
            u_xlat3 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat3 = u_xlat3 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_4 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_4 = (bool(u_xlatb39)) ? u_xlat16_4 : u_xlat1;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlat5 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat5 = u_xlat5 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_1 = (u_xlati2.y != 0) ? u_xlat16_8 : u_xlat1;
            u_xlat16_5 = (u_xlati2.y != 0) ? u_xlat5 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati2.x != 0) ? u_xlat16_4 : u_xlat16_1;
            u_xlat16_7 = (u_xlati2.x != 0) ? u_xlat3 : u_xlat16_5;
            u_xlati0 = int(uint(u_xlati2.y) | uint(u_xlati2.x));
        //ENDIF
        }
        u_xlat1 = u_xlat16_7 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_7 : u_xlat1;
    //ENDIF
    }
    if(u_xlati0 != 0) {
        u_xlat16_0 = u_xlat16_6 + u_xlat16_11;
        u_xlat16_1 = (-u_xlat16_0) + u_xlat16_6;
        u_xlat0 = vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount)) * u_xlat16_1 + u_xlat16_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        SV_Target0 = u_xlat16_11;
        return;
    //ENDIF
    }
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform 	float _LineIntensity;
uniform 	mediump vec4 _LineColor1;
uniform 	mediump vec4 _LineColor2;
uniform 	mediump vec4 _LineColor3;
uniform 	int _FlipY;
uniform 	int _Dark;
uniform 	float _FillAmount;
uniform 	int _CornerOutlines;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
ivec4 u_xlati6;
bvec4 u_xlatb6;
vec4 u_xlat7;
mediump vec4 u_xlat16_7;
bvec4 u_xlatb7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec4 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
bvec2 u_xlatb15;
bvec2 u_xlatb19;
vec2 u_xlat26;
bool u_xlatb26;
vec2 u_xlat28;
bvec2 u_xlatb28;
vec2 u_xlat30;
bvec2 u_xlatb32;
bool u_xlatb39;
bool u_xlatb41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_FlipY==1);
#else
    u_xlatb0 = _FlipY==1;
#endif
    u_xlat13 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat13 : vs_TEXCOORD0.y;
    u_xlat26.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat26.xy);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat26.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat26.x = texture(_OutlineSource, u_xlat26.xy).w;
    u_xlat2.x = _LineThicknessX;
    u_xlat2.y = float(0.0);
    u_xlat28.y = float(0.0);
    u_xlat2.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat28.x = (-_LineThicknessX);
    u_xlat2.xy = u_xlat0.xy + u_xlat28.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat4.x = float(0.0);
    u_xlat30.x = float(0.0);
    u_xlat4.y = _LineThicknessY;
    u_xlat4.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat5.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
    u_xlat30.y = (-_LineThicknessY);
    u_xlat4.xy = u_xlat0.xy + u_xlat30.xy;
    u_xlat4.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat26.x<0.949999988);
#else
    u_xlatb26 = u_xlat26.x<0.949999988;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(_Dark!=0);
#else
    u_xlatb39 = _Dark!=0;
#endif
    u_xlatb39 = u_xlatb39 && u_xlatb26;
    if(_CornerOutlines != 0) {
        u_xlat6.xy = u_xlat0.xy + vec2(_LineThicknessX, _LineThicknessY);
        u_xlat6.xyz = texture(_OutlineSource, u_xlat6.xy).xyz;
        u_xlat7.xy = u_xlat0.xy + (-vec2(_LineThicknessX, _LineThicknessY));
        u_xlat7.xyz = texture(_OutlineSource, u_xlat7.xy).xyz;
        u_xlat8 = vec4(_LineThicknessX, _LineThicknessY, _LineThicknessX, _LineThicknessY) * vec4(1.0, -1.0, -1.0, 1.0) + u_xlat0.xyxy;
        u_xlat9.xyz = texture(_OutlineSource, u_xlat8.xy).xyz;
        u_xlat8.xyz = texture(_OutlineSource, u_xlat8.zw).xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb0 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb13 = 0.949999988<u_xlat2.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb13 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb13 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat6.x);
#else
        u_xlatb13 = 0.949999988<u_xlat6.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat7.x);
#else
        u_xlatb13 = 0.949999988<u_xlat7.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat9.x);
#else
        u_xlatb13 = 0.949999988<u_xlat9.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat8.x);
#else
        u_xlatb13 = 0.949999988<u_xlat8.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
        if(u_xlatb0){
            u_xlat10 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat10 = u_xlat10 * _LineColor1.wwww;
            u_xlat16_11.x = (-_LineColor1.w) + 1.0;
            u_xlat16_11 = u_xlat1 * u_xlat16_11.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_11 : u_xlat1;
            u_xlat16_10 = u_xlat10;
            u_xlati0 = -1;
        } else {
            u_xlatb6.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat2.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlatb6.xw) * 0xffffffffu | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat5.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat4.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb19.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat6.yzyy).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb19.xy) * 0xffffffffu | uvec2(u_xlati6.xw));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat7.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat9.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat8.yzyz).xy;
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat7 = u_xlat7 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlat9 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat9 = u_xlat9 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_12 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_12 = (bool(u_xlatb39)) ? u_xlat16_12 : u_xlat1;
            u_xlat16_12 = (u_xlati6.y != 0) ? u_xlat16_12 : u_xlat1;
            u_xlat16_9 = (u_xlati6.y != 0) ? u_xlat9 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati6.x != 0) ? u_xlat16_8 : u_xlat16_12;
            u_xlat16_10 = (u_xlati6.x != 0) ? u_xlat7 : u_xlat16_9;
            u_xlati0 = int(uint(u_xlati6.y) | uint(u_xlati6.x));
        //ENDIF
        }
        u_xlat6 = u_xlat16_10 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_10 : u_xlat6;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb41 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb2.x = 0.949999988<u_xlat2.x;
#endif
        u_xlatb2.x = u_xlatb2.x || u_xlatb41;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb41 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb41 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
        if(u_xlatb2.x){
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat7 = u_xlat7 * _LineColor1.wwww;
            u_xlat16_12.x = (-_LineColor1.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_7 = u_xlat7;
            u_xlati0 = -1;
        } else {
            u_xlatb2.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb15.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat2.yzyy).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb15.xy) * 0xffffffffu | uvec2(u_xlatb2.xw) * 0xffffffffu);
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat5.yzyz).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat4.yzyz).xy;
            u_xlat3 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat3 = u_xlat3 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_4 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_4 = (bool(u_xlatb39)) ? u_xlat16_4 : u_xlat1;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlat5 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat5 = u_xlat5 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_1 = (u_xlati2.y != 0) ? u_xlat16_8 : u_xlat1;
            u_xlat16_5 = (u_xlati2.y != 0) ? u_xlat5 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati2.x != 0) ? u_xlat16_4 : u_xlat16_1;
            u_xlat16_7 = (u_xlati2.x != 0) ? u_xlat3 : u_xlat16_5;
            u_xlati0 = int(uint(u_xlati2.y) | uint(u_xlati2.x));
        //ENDIF
        }
        u_xlat1 = u_xlat16_7 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_7 : u_xlat1;
    //ENDIF
    }
    if(u_xlati0 != 0) {
        u_xlat16_0 = u_xlat16_6 + u_xlat16_11;
        u_xlat16_1 = (-u_xlat16_0) + u_xlat16_6;
        u_xlat0 = vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount)) * u_xlat16_1 + u_xlat16_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        SV_Target0 = u_xlat16_11;
        return;
    //ENDIF
    }
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	float _LineThicknessX;
uniform 	float _LineThicknessY;
uniform 	float _LineIntensity;
uniform 	mediump vec4 _LineColor1;
uniform 	mediump vec4 _LineColor2;
uniform 	mediump vec4 _LineColor3;
uniform 	int _FlipY;
uniform 	int _Dark;
uniform 	float _FillAmount;
uniform 	int _CornerOutlines;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _OutlineSource;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
ivec4 u_xlati6;
bvec4 u_xlatb6;
vec4 u_xlat7;
mediump vec4 u_xlat16_7;
bvec4 u_xlatb7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec4 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
bvec2 u_xlatb15;
bvec2 u_xlatb19;
vec2 u_xlat26;
bool u_xlatb26;
vec2 u_xlat28;
bvec2 u_xlatb28;
vec2 u_xlat30;
bvec2 u_xlatb32;
bool u_xlatb39;
bool u_xlatb41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_FlipY==1);
#else
    u_xlatb0 = _FlipY==1;
#endif
    u_xlat13 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat13 : vs_TEXCOORD0.y;
    u_xlat26.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat26.xy);
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat26.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat26.x = texture(_OutlineSource, u_xlat26.xy).w;
    u_xlat2.x = _LineThicknessX;
    u_xlat2.y = float(0.0);
    u_xlat28.y = float(0.0);
    u_xlat2.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat3.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat28.x = (-_LineThicknessX);
    u_xlat2.xy = u_xlat0.xy + u_xlat28.xy;
    u_xlat2.xyz = texture(_OutlineSource, u_xlat2.xy).xyz;
    u_xlat4.x = float(0.0);
    u_xlat30.x = float(0.0);
    u_xlat4.y = _LineThicknessY;
    u_xlat4.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat5.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
    u_xlat30.y = (-_LineThicknessY);
    u_xlat4.xy = u_xlat0.xy + u_xlat30.xy;
    u_xlat4.xyz = texture(_OutlineSource, u_xlat4.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat26.x<0.949999988);
#else
    u_xlatb26 = u_xlat26.x<0.949999988;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(_Dark!=0);
#else
    u_xlatb39 = _Dark!=0;
#endif
    u_xlatb39 = u_xlatb39 && u_xlatb26;
    if(_CornerOutlines != 0) {
        u_xlat6.xy = u_xlat0.xy + vec2(_LineThicknessX, _LineThicknessY);
        u_xlat6.xyz = texture(_OutlineSource, u_xlat6.xy).xyz;
        u_xlat7.xy = u_xlat0.xy + (-vec2(_LineThicknessX, _LineThicknessY));
        u_xlat7.xyz = texture(_OutlineSource, u_xlat7.xy).xyz;
        u_xlat8 = vec4(_LineThicknessX, _LineThicknessY, _LineThicknessX, _LineThicknessY) * vec4(1.0, -1.0, -1.0, 1.0) + u_xlat0.xyxy;
        u_xlat9.xyz = texture(_OutlineSource, u_xlat8.xy).xyz;
        u_xlat8.xyz = texture(_OutlineSource, u_xlat8.zw).xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb0 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb13 = 0.949999988<u_xlat2.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb13 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb13 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat6.x);
#else
        u_xlatb13 = 0.949999988<u_xlat6.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat7.x);
#else
        u_xlatb13 = 0.949999988<u_xlat7.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat9.x);
#else
        u_xlatb13 = 0.949999988<u_xlat9.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(0.949999988<u_xlat8.x);
#else
        u_xlatb13 = 0.949999988<u_xlat8.x;
#endif
        u_xlatb0 = u_xlatb13 || u_xlatb0;
        if(u_xlatb0){
            u_xlat10 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat10 = u_xlat10 * _LineColor1.wwww;
            u_xlat16_11.x = (-_LineColor1.w) + 1.0;
            u_xlat16_11 = u_xlat1 * u_xlat16_11.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_11 : u_xlat1;
            u_xlat16_10 = u_xlat10;
            u_xlati0 = -1;
        } else {
            u_xlatb6.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat2.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlatb6.xw) * 0xffffffffu | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat5.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb7.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat4.yyyz).xw;
            u_xlati6.xw = ivec2(uvec2(u_xlati6.xw) | uvec2(u_xlatb7.xw) * 0xffffffffu);
            u_xlatb19.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat6.yzyy).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb19.xy) * 0xffffffffu | uvec2(u_xlati6.xw));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat7.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat9.yzyz).xy;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlatb32.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat8.yzyz).xy;
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat7 = u_xlat7 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlati6.xy = ivec2(uvec2(u_xlatb32.xy) * 0xffffffffu | uvec2(u_xlati6.xy));
            u_xlat9 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat9 = u_xlat9 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_12 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_12 = (bool(u_xlatb39)) ? u_xlat16_12 : u_xlat1;
            u_xlat16_12 = (u_xlati6.y != 0) ? u_xlat16_12 : u_xlat1;
            u_xlat16_9 = (u_xlati6.y != 0) ? u_xlat9 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati6.x != 0) ? u_xlat16_8 : u_xlat16_12;
            u_xlat16_10 = (u_xlati6.x != 0) ? u_xlat7 : u_xlat16_9;
            u_xlati0 = int(uint(u_xlati6.y) | uint(u_xlati6.x));
        //ENDIF
        }
        u_xlat6 = u_xlat16_10 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_10 : u_xlat6;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat3.x);
#else
        u_xlatb41 = 0.949999988<u_xlat3.x;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(0.949999988<u_xlat2.x);
#else
        u_xlatb2.x = 0.949999988<u_xlat2.x;
#endif
        u_xlatb2.x = u_xlatb2.x || u_xlatb41;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat5.x);
#else
        u_xlatb41 = 0.949999988<u_xlat5.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb41 = !!(0.949999988<u_xlat4.x);
#else
        u_xlatb41 = 0.949999988<u_xlat4.x;
#endif
        u_xlatb2.x = u_xlatb41 || u_xlatb2.x;
        if(u_xlatb2.x){
            u_xlat7 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor1;
            u_xlat7 = u_xlat7 * _LineColor1.wwww;
            u_xlat16_12.x = (-_LineColor1.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_11 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_7 = u_xlat7;
            u_xlati0 = -1;
        } else {
            u_xlatb2.xw = lessThan(vec4(0.949999988, 0.0, 0.0, 0.949999988), u_xlat3.yyyz).xw;
            u_xlatb15.xy = lessThan(vec4(0.949999988, 0.949999988, 0.0, 0.0), u_xlat2.yzyy).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb15.xy) * 0xffffffffu | uvec2(u_xlatb2.xw) * 0xffffffffu);
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat5.yzyz).xy;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlatb28.xy = lessThan(vec4(0.949999988, 0.949999988, 0.949999988, 0.949999988), u_xlat4.yzyz).xy;
            u_xlat3 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor2;
            u_xlat3 = u_xlat3 * _LineColor2.wwww;
            u_xlat16_12.x = (-_LineColor2.w) + 1.0;
            u_xlat16_4 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_4 = (bool(u_xlatb39)) ? u_xlat16_4 : u_xlat1;
            u_xlati2.xy = ivec2(uvec2(u_xlatb28.xy) * 0xffffffffu | uvec2(u_xlati2.xy));
            u_xlat5 = vec4(vec4(_LineIntensity, _LineIntensity, _LineIntensity, _LineIntensity)) * _LineColor3;
            u_xlat5 = u_xlat5 * _LineColor3.wwww;
            u_xlat16_12.x = (-_LineColor3.w) + 1.0;
            u_xlat16_8 = u_xlat1 * u_xlat16_12.xxxx;
            u_xlat16_8 = (bool(u_xlatb39)) ? u_xlat16_8 : u_xlat1;
            u_xlat16_1 = (u_xlati2.y != 0) ? u_xlat16_8 : u_xlat1;
            u_xlat16_5 = (u_xlati2.y != 0) ? u_xlat5 : vec4(0.0, 0.0, 0.0, 0.0);
            u_xlat16_11 = (u_xlati2.x != 0) ? u_xlat16_4 : u_xlat16_1;
            u_xlat16_7 = (u_xlati2.x != 0) ? u_xlat3 : u_xlat16_5;
            u_xlati0 = int(uint(u_xlati2.y) | uint(u_xlati2.x));
        //ENDIF
        }
        u_xlat1 = u_xlat16_7 * vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount));
        u_xlat16_6 = (bool(u_xlatb26)) ? u_xlat16_7 : u_xlat1;
    //ENDIF
    }
    if(u_xlati0 != 0) {
        u_xlat16_0 = u_xlat16_6 + u_xlat16_11;
        u_xlat16_1 = (-u_xlat16_0) + u_xlat16_6;
        u_xlat0 = vec4(vec4(_FillAmount, _FillAmount, _FillAmount, _FillAmount)) * u_xlat16_1 + u_xlat16_0;
        SV_Target0 = u_xlat0;
        return;
    } else {
        SV_Target0 = u_xlat16_11;
        return;
    //ENDIF
    }
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