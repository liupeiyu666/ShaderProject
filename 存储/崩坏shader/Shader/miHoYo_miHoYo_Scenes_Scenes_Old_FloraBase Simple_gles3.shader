//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/FloraBase Simple" {
Properties {
_Diffuse ("Diffuse", 2D) = "black" { }
_AlphaCutoff ("Alpha Cutoff", Float) = 1
_WindMask ("WindMask", 2D) = "bump" { }
_Frequency ("Shake Frequency", Float) = 1
_MainWindStr ("Main Wind Str", Float) = 0.3
_MainWindvector ("Main Wind vector", Vector) = (0,0,0,0)
_AdditionalwindGradient ("Additional wind Gradient", 2D) = "white" { }
_Additionalwindstr ("Additional wind str", Float) = 0.01
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "DrawDepth" = "FrontFaceClip" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 15516
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat3 = u_xlat10_0.w * _AlphaCutoff + -0.5;
    SV_Target0.xyz = u_xlat10_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3<0.0);
#else
    u_xlatb0 = u_xlat3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat3 = u_xlat10_0.w * _AlphaCutoff + -0.5;
    SV_Target0.xyz = u_xlat10_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3<0.0);
#else
    u_xlatb0 = u_xlat3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat3 = u_xlat10_0.w * _AlphaCutoff + -0.5;
    SV_Target0.xyz = u_xlat10_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat3<0.0);
#else
    u_xlatb0 = u_xlat3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat6 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<0.0);
#else
    u_xlatb6 = u_xlat6<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat16_6 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_6);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat10_0.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat6 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<0.0);
#else
    u_xlatb6 = u_xlat6<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat16_6 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_6);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat10_0.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat6 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat6);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat6 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<0.0);
#else
    u_xlatb6 = u_xlat6<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat16_6 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_6);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _WindMask_ST;
uniform 	float _MainWindStr;
uniform 	float _Additionalwindstr;
uniform 	vec4 _AdditionalwindGradient_ST;
uniform 	vec4 _MainWindvector;
uniform 	float _Frequency;
uniform lowp sampler2D _AdditionalwindGradient;
uniform lowp sampler2D _WindMask;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _Frequency;
    u_xlat0.xy = u_xlat0.xx * vec2(0.100000001, 0.0) + in_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _AdditionalwindGradient_ST.xy + _AdditionalwindGradient_ST.zw;
    u_xlat0.xyz = textureLod(_AdditionalwindGradient, u_xlat0.xy, 0.0).xyz;
    u_xlat9 = _Frequency * _Time.y + 3.14159274;
    u_xlat0.w = sin(u_xlat9);
    u_xlat0 = u_xlat0 * vec4(_Additionalwindstr, _Additionalwindstr, _Additionalwindstr, _MainWindStr);
    u_xlat1.xyz = u_xlat0.www * _MainWindvector.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD2.xy * _WindMask_ST.xy + _WindMask_ST.zw;
    u_xlat1.xyz = textureLod(_WindMask, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzwy * in_POSITION0.wwww + u_xlat0.xzwy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD2.xy;
    vs_TEXCOORD2 = u_xlat0.xwyz;
    u_xlat1.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_UWFogDistStart);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xy = u_xlat1.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat1.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 _Diffuse_ST;
uniform 	float _AlphaCutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Diffuse;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb5;
vec3 u_xlat7;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_0 = texture(_Diffuse, u_xlat0.xy);
    u_xlat12 = u_xlat10_0.w * _AlphaCutoff + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat12 = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat1.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12 = u_xlat12 / u_xlat1.x;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat1.x = (-u_xlat12) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb5 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_2 = (u_xlatb5) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat1.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xxx * u_xlat1.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = u_xlat10_0.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat16_2) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat3.x = u_xlat12 * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat12 + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat10_0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    SV_Target0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}